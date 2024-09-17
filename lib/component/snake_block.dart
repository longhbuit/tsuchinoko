import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:tsuchinoko/component/snake_game.dart';
import 'package:tsuchinoko/component/types.dart';
import 'package:tsuchinoko/game_config.dart';

class SnakeBlock extends SpriteComponent with HasGameRef<SnakeGame> {
  SnakeBlock? nextBlock;
  SnakeBlock? prevBlock;
  late Sprite body;
  late Sprite head;
  late Sprite tail;
  late Sprite corner;

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

  @override
  Future<dynamic> onLoad() async {
    head = await Sprite.load('head.png');
    body = await Sprite.load('body.png');
    tail = await Sprite.load('tail.png');
    corner = await Sprite.load('body_corner.png');
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
      sprite = head;
      angle = direction.angle();
    } else if (prevBlock == null) {
      sprite = tail;
      angle = direction.angle();
    } else {
      if (prevBlock!.direction == direction) {
        sprite = body;
        angle = direction.angle();
      } else {
        sprite = corner;
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
