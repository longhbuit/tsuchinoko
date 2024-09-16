import 'dart:math';

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

  double angle() {
    switch (this) {
      case up:
        return 0;
      case right:
        return pi / 2;
      case down:
        return pi;
      case left:
        return 3 * pi / 2;
    }
  }
}