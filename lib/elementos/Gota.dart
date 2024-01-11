import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:juegoclase/games/ClassGame.dart';

class Gota extends SpriteAnimationComponent
    with HasGameRef<ClassGame>,CollisionCallbacks{

  Gota({
    required super.position, required super.size
  }) : super(anchor: Anchor.center);


  @override
  Future<void> onLoad() async{
    // TODO: implement onLoad

    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('water_enemy.png'),
      SpriteAnimationData.sequenced(
        amount: 2,
        amountPerRow: 2,
        textureSize: Vector2(16,16),
        stepTime: 0.12,
      ),
    );



    return super.onLoad();
  }

}