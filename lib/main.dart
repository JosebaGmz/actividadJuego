import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'games/ClassGame.dart';

void main() {
  runApp(
    const GameWidget<ClassGame>.controlled(
      gameFactory: ClassGame.new,
    ),
  );
}