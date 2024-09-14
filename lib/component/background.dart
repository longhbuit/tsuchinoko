import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:tsuchinoko/component/snake_game.dart';

class BackGround extends PositionComponent with HasGameRef<SnakeGame> {
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, gameRef.cols * gameRef.cellSize,
          gameRef.rows * gameRef.cellSize),
      Paint()..color = Colors.blue,
    );
  }
}
