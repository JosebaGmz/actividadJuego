
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:forge2d/src/dynamics/body.dart';

import '../elementos/Gota.dart';
import '../games/ClassGame.dart';

class GotaBody extends BodyComponent<ClassGame> with ContactCallbacks{
  Vector2 posXY;
  Vector2 tamWH;
  double xIni=0;
  double xFin=0;
  double xContador=0;
  double dAnimDireccion=-1;
  double dVelocidadAnim=1;

  GotaBody({required this.posXY,required this.tamWH}):super();

  @override
  Body createBody() {
    // TODO: implement createBody

    BodyDef bodyDef = BodyDef(type: BodyType.dynamic,position: posXY,gravityOverride: Vector2(0,0));
    Body cuerpo=world.createBody(bodyDef);
    CircleShape shape=CircleShape();
    shape.radius=tamWH.x/2;

    // userData: this, // To be able to determine object in collision
    Fixture fix=cuerpo.createFixtureFromShape(shape);
    //fix.density=100;
    //fix.restitution=5.0;
    fix.userData=this;

    return cuerpo;
  }

  @override
  Future<void> onLoad() async{
    // TODO: implement onLoad
    await super.onLoad();

    Gota gotaPlayer=Gota(position: Vector2.zero(), size: tamWH);
    add(gotaPlayer);

    xIni=posXY.x;
    xFin=(40);
    xContador=0;

  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);



  }


}