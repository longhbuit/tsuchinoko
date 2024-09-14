import 'dart:math';

import 'package:flame/game.dart';
import 'package:tsuchinoko/component/background.dart';
import 'package:tsuchinoko/component/snake_block.dart';
import 'package:tsuchinoko/game_config.dart';

class SnakeGame extends FlameGame {
  int cols = GameConfig.columns;
  int rows = GameConfig.rows;
  double cellSize = GameConfig.cellSize;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(BackGround());
    add(SnakeBlock(pos: Vector2(1, 2)));
  }

  Vector2 randomCell() {
    // Random cell in cols and rows
    return Vector2(
      Random().nextInt(cols).toDouble(),
      Random().nextInt(rows).toDouble(),
    );
  }
}
