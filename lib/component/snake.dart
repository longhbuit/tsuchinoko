import 'dart:async';
import 'dart:collection';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:tsuchinoko/component/events.dart';
import 'package:tsuchinoko/component/snake_block.dart';
import 'package:tsuchinoko/component/snake_game.dart';
import 'package:tsuchinoko/component/types.dart';

class Snake extends Component with HasGameRef<SnakeGame> {
  late SnakeBlock tail;
  late SnakeBlock head;
  Queue<Direction> queueDirection = Queue<Direction>();

  bool alive = true;

  Snake() {
    tail = SnakeBlock(pos: Vector2(0, 10), direction: Direction.right);
    head = tail.addBlock(Direction.right).addBlock(Direction.right);
  }

  void move() {
    checkAlive();
    if (!alive) {
      return;
    }
    var upcomingDirection = queueDirection.first;
    head.direction = upcomingDirection;
    if (queueDirection.length > 1) {
      queueDirection.removeFirst();
    }
    if (checkEating()) {
      eat();
      gameRef.eventBus.fire(FoodEatenEvent());
    } else {
      SnakeBlock block = tail;
      tail = tail.nextBlock!;
      tail.prevBlock = null;

      head.nextBlock = block;
      block.nextBlock = null;
      block.prevBlock = head;
      block.pos = head.pos + head.direction.opposite;
      block.direction = head.direction;
      block.position = block.pos * gameRef.cellSize + SnakeBlock.halfSizeVector;
      head = block;
    }
  }

  void checkAlive() {
    var upcomingDirection = queueDirection.first;
    var newPos = head.pos + upcomingDirection.opposite;
    if (newPos.x < 0 ||
        newPos.x >= gameRef.cols ||
        newPos.y < 0 ||
        newPos.y >= gameRef.rows) {
      alive = false;
      return;
    }
    var block = tail.nextBlock;
    while (block != null) {
      if (block.pos == newPos) {
        alive = false;
        return;
      }
      block = block.nextBlock;
    }
  }

  @override
  Future<dynamic> onLoad() async {
    queueDirection.add(Direction.right);
    SnakeBlock? block = tail;
    while (block != null) {
      gameRef.add(block);
      block = block.nextBlock;
    }
    return Future.value();
  }

  static Vector2 VECTOR_ZERO = Vector2(0, 0);

  void changeDirection(Direction direction) {

    if (queueDirection.last.opposite + direction.opposite == VECTOR_ZERO) {
      return;
    }
    queueDirection.addLast(direction);
  }

  bool checkEating() {
    /**
     * Check if the head is in the same position as the food
     * If eating then add a new block to the snake and not move
     */
    print(head.pos + head.direction.opposite);
    print(gameRef.food.position);
    return head.pos + head.direction.opposite == gameRef.food.pos;
  }

  void eat() {
    print("Snake is eating");
    head = head.addBlock(head.direction);
    gameRef.add(head);
  }

  List<Vector2> get body {
    List<Vector2> bodyPositions = [];
    SnakeBlock? currentBlock = tail;
    while (currentBlock != null) {
      bodyPositions.add(currentBlock.pos);
      currentBlock = currentBlock.nextBlock;
    }
    return bodyPositions;
  }
}
