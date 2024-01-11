import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../games/ClassGame.dart';

class Estrella extends SpriteComponent
    with HasGameRef<ClassGame>,CollisionCallbacks{

  final _collisionStartColor = Colors.black87;
  final _defaultColor = Colors.red;
  late ShapeHitbox hitbox;

  Estrella({required super.position,required super.size});

  @override
  Future<void> onLoad() async {
    // TODO: implement onLoad
    sprite=Sprite(game.images.fromCache('star.png'));
    anchor=Anchor.center;


    final defaultPaint = Paint()
      ..color = _defaultColor
      ..style = PaintingStyle.stroke;

    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..isSolid=true
      ..renderShape = true;
    add(hitbox);

    return super.onLoad();
  }
}