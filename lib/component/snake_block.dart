import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tsuchinoko/component/snake_game.dart';
import 'package:tsuchinoko/component/types.dart';
import 'package:tsuchinoko/game_config.dart';

class SnakeBlock extends PositionComponent with HasGameRef<SnakeGame> {
  SnakeBlock? nextBlock;
  SnakeBlock? prevBlock;
  Direction direction;
  Vector2 pos;

  SnakeBlock({required this.pos, required this.direction})
      : super(position: pos * GameConfig.cellSize);

  SnakeBlock addBlock(Direction direction) {
    final newBlock =
        SnakeBlock(pos: pos + direction.opposite, direction: direction);
    nextBlock = newBlock;
    newBlock.prevBlock = this;
    return newBlock;
  }

  void move() {
    if (nextBlock != null) {
      direction = nextBlock!.direction;
      pos = nextBlock!.pos;
      position = pos * GameConfig.cellSize;
    } else {
      pos = pos + direction.opposite;
      position = pos * GameConfig.cellSize;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, gameRef.cellSize, gameRef.cellSize),
      Paint()..color = Colors.green,
    );
  }
}
