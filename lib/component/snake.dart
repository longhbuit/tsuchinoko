import 'dart:ui';

import 'package:flame/components.dart';
import 'package:tsuchinoko/component/events.dart';
import 'package:tsuchinoko/component/snake_block.dart';
import 'package:tsuchinoko/component/snake_game.dart';
import 'package:tsuchinoko/component/types.dart';

class Snake extends Component with HasGameRef<SnakeGame> {
  late SnakeBlock tail;
  late SnakeBlock head;
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

    if (checkEating()) {
      eat();
      gameRef.eventBus.fire(FoodEatenEvent());
    } else {
      SnakeBlock block = tail;
      while (block.nextBlock != null) {
        block.move();
        block = block.nextBlock!;
      }
      block.move();
    }
  }

  void checkAlive() {
    var newPos = head.pos + head.direction.opposite;
    if (newPos.x < 0 ||
        newPos.x >= gameRef.cols ||
        newPos.y < 0 ||
        newPos.y >= gameRef.rows) {
      alive = false;
      return;
    }
    var block = tail.nextBlock;
    while (block != null)
      {
        if (block.pos ==newPos) {
          alive = false;
          return;
        }
        block = block.nextBlock;
      }
  }

  @override
  void render(Canvas canvas) {
    SnakeBlock? block = tail;
    while (block != null) {
      gameRef.add(block);
      block = block.nextBlock;
    }
  }
static Vector2 VECTOR_ZERO = Vector2(0, 0);
  void changeDirection(Direction direction) {
    if (head.direction.opposite+direction.opposite==VECTOR_ZERO){
      return;
    }
    head.direction = direction;
  }

  bool checkEating() {
    /**
     * Check if the head is in the same position as the food
     * If eating then add a new block to the snake and not move
     */
    print(head.pos+head.direction.opposite);
    print(gameRef.food.position);
    return head.pos+head.direction.opposite == gameRef.food.pos;
  }

  void eat() {
    print("Snake is eating");
    head = head.addBlock(head.direction);
  }
}
