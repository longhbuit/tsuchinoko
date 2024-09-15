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
    var newPos = head.pos + head.direction.opposite;
    if (newPos.x < 0 ||
        newPos.x >= gameRef.cols ||
        newPos.y < 0 ||
        newPos.y >= gameRef.rows) {
      alive = false;
    }
    if (!alive) {
      return;
    }
    SnakeBlock block = tail;
    while (block.nextBlock != null) {
      block.move();
      block = block.nextBlock!;
    }
    block.move();
    print(head.pos);
    print( gameRef.rows);
    gameRef.eventBus.fire(FoodEatenEvent());
  }

  @override
  void render(Canvas canvas) {
    SnakeBlock? block = tail;
    while (block != null) {
      gameRef.add(block);
      block = block.nextBlock;
    }
  }

  void changeDirection(Direction direction) {
    head.direction = direction;
  }
}
