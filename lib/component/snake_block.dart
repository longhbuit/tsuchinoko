import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tsuchinoko/component/snake_game.dart';
import 'package:tsuchinoko/component/types.dart';
import 'package:tsuchinoko/game_config.dart';

class SnakeBlock extends SpriteComponent with HasGameRef<SnakeGame> {
  SnakeBlock? nextBlock;
  SnakeBlock? prevBlock;
  Direction direction;
  Vector2 pos;
  static Vector2 halfSizeVector =
      Vector2(GameConfig.cellSize / 2, GameConfig.cellSize / 2);

  SnakeBlock({required this.pos, required this.direction})
      : super(position: pos * GameConfig.cellSize + halfSizeVector) {
    anchor = Anchor.center;
  }

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
      position = pos * GameConfig.cellSize + halfSizeVector;
    } else {
      pos = pos + direction.opposite;
      position = pos * GameConfig.cellSize + halfSizeVector;
    }
  }

  @override
  Future<dynamic> onLoad() async {
    super.onLoad();
    await draw();
    return Future.value();
  }

  @override
  Future<void> render(Canvas canvas) async {
    super.render(canvas);
    await draw();
  }

  Future<void> draw() async {
    if (nextBlock == null) {
      sprite = await Sprite.load('head.png');
      angle = direction.angle();
    } else if (prevBlock == null) {
      sprite = await Sprite.load('tail.png');
      angle = direction.angle();
    } else {
      if (prevBlock!.direction == direction) {
        sprite = await Sprite.load('body.png');
        angle = direction.angle();
      } else {
        sprite = await Sprite.load('body_corner.png');
        angle = calculateCornerAngle(prevBlock!.direction, direction);
      }
    }
  }

  double calculateCornerAngle(Direction prevDirection, Direction direction) {
    if ((prevDirection == Direction.up && direction == Direction.right) ||
        (prevDirection == Direction.left && direction == Direction.down)) {
      return pi / 2;
    } else if ((prevDirection == Direction.right && direction == Direction.down) ||
        (prevDirection == Direction.up && direction == Direction.left)) {
      return pi;
    } else if ((prevDirection == Direction.down && direction == Direction.left) ||
        (prevDirection == Direction.right && direction == Direction.up)) {
      return -pi / 2;
    } else if ((prevDirection == Direction.left && direction == Direction.up) ||
        (prevDirection == Direction.down && direction == Direction.right)) {
      return 0;
    }
    return 0;
  }
}
