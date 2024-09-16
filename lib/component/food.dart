
import 'package:flame/components.dart';
import 'package:tsuchinoko/component/snake_game.dart';
import 'package:tsuchinoko/game_config.dart';

import 'events.dart';

class Food extends SpriteComponent with HasGameRef<SnakeGame> {
  Vector2 pos;

  Food({required this.pos})
      : super(position: pos * GameConfig.cellSize);

  @override
  Future<dynamic> onLoad() async {
    sprite = await Sprite.load("food.png");
    return super.onLoad();
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
