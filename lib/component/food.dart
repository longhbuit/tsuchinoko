import 'package:flame/components.dart';
import 'package:tsuchinoko/component/snake_game.dart';

class Food extends PositionComponent with HasGameRef<SnakeGame> {
  @override
  void onMount() {
    super.onMount();
    position = gameRef.randomCell();
  }
}
