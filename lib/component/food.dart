import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tsuchinoko/component/snake_game.dart';
import 'package:tsuchinoko/game_config.dart';

import 'events.dart';

class Food extends PositionComponent with HasGameRef<SnakeGame> {
  Vector2 pos;

  Food({required Vector2 this.pos})
      : super(position: pos * GameConfig.cellSize);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
      Rect.fromLTWH(0, 0, gameRef.cellSize, gameRef.cellSize),
      Paint()..color = Colors.red,
    );
  }

  @override
  void onMount() {
    super.onMount();
    gameRef.eventBus.on<FoodEatenEvent>().listen((event) {
      respawn();
    });
  }

  void respawn() {
    pos = gameRef.randomCell();
    position = pos * GameConfig.cellSize;
  }
}
