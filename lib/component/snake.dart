import 'dart:ui';

import 'package:flame/components.dart';
import 'package:tsuchinoko/component/snake_block.dart';
import 'package:tsuchinoko/component/snake_game.dart';
import 'package:tsuchinoko/component/types.dart';

class Snake extends Component with HasGameRef<SnakeGame> {
  late SnakeBlock tail;
  late SnakeBlock head;

  Snake() {
    tail = SnakeBlock(pos: Vector2(0, 10), direction: Direction.right);
    head = tail.addBlock(Direction.right).addBlock(Direction.right);
  }

  void move() {
    SnakeBlock block = tail;
    while (block.nextBlock != null) {
      block.move();
      block = block.nextBlock!;
    }
    block.move();
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
