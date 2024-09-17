import 'dart:math';

import 'package:event_bus/event_bus.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:tsuchinoko/component/background.dart';
import 'package:tsuchinoko/component/snake.dart';
import 'package:tsuchinoko/component/types.dart';
import 'package:tsuchinoko/game_config.dart';

import 'food.dart';

class SnakeGame extends FlameGame with KeyboardEvents {
  int cols = GameConfig.columns;
  int rows = GameConfig.rows;
  double cellSize = GameConfig.cellSize;
  int score = 0;
  late Timer timer;
  late Snake snake;
  late Food food;
  late EventBus eventBus;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    snake = Snake();
    food = Food(pos: randomCell());
    eventBus = EventBus();

    timer = Timer(1, repeat: true, onTick: snake.move);
    add(BackGround());
    add(snake);
    add(food);
    add(TimerComponent(period: .2, onTick: onTickTimer, repeat: true));
  }

  void onTickTimer() {
    snake.move();
  }

  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is KeyDownEvent;

    if (isKeyDown) {
      switch (event.logicalKey) {
        case LogicalKeyboardKey.arrowUp:
          snake.changeDirection(Direction.up);
          break;
        case LogicalKeyboardKey.arrowRight:
          snake.changeDirection(Direction.right);
          break;
        case LogicalKeyboardKey.arrowDown:
          snake.changeDirection(Direction.down);
          break;
        case LogicalKeyboardKey.arrowLeft:
          snake.changeDirection(Direction.left);
          break;
      }
    }
    return KeyEventResult.ignored;
  }

  Vector2 randomCell() {
    Vector2 newPos;
    do {
      newPos = Vector2(
        Random().nextInt(cols).toDouble(),
        Random().nextInt(rows).toDouble(),
      );
    } while (snake.body.contains(newPos)); // Kiểm tra xem ô mới có bị rắn chiếm giữ không
    return newPos;
  }
}
