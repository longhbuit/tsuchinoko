import 'package:flame/components.dart';

enum Direction {
  up,
  right,
  down,
  left;

  Vector2 get opposite {
    switch (this) {
      case up:
        return Vector2(0, -1);
      case right:
        return Vector2(1, 0);
      case down:
        return Vector2(0, 1);
      case left:
        return Vector2(-1, 0);
    }
  }
}