import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:juegoclase/games/ClassGame.dart';

import '../elementos/Gota.dart';

class SecondPlayer extends SpriteAnimationComponent
    with HasGameRef<ClassGame> {

  late int iTipo=-1;


  SecondPlayer({
    required super.position,required this.iTipo
    ,required super.size
  }) : super( anchor: Anchor.center);

  @override
  void onLoad() {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache('ember.png'),
      SpriteAnimationData.sequenced(
        amount: 4,
        textureSize: Vector2.all(16),
        stepTime: 0.22,
      ),
    );

  }

}

class SecondPlayerBody extends BodyComponent with KeyboardHandler,ContactCallbacks{
  final Vector2 velocidad = Vector2.zero();
  final double aceleracion = 200;
  final Set<LogicalKeyboardKey> magiaSubZero={LogicalKeyboardKey.arrowDown, LogicalKeyboardKey.keyA};
  final Set<LogicalKeyboardKey> magiaScorpio={LogicalKeyboardKey.arrowUp, LogicalKeyboardKey.keyK};
  late int iTipo=-1;
  late Vector2 tamano;
  int horizontalDirection = 0;
  int verticalDirection = 0;
  static const  int I_PLAYER_SUBZERO=0;
  static const  int I_PLAYER_SCORPIO=1;
  static const  int I_PLAYER_TANYA=2;
  final _defaultColor = Colors.red;
  late SecondPlayer secondPlayer;
  late double jumpSpeed=0.0;
  Vector2 initialPosition;
  bool blEspacioLiberado=true;
  int iVidas=3;

  SecondPlayerBody({required this.initialPosition,required this.iTipo,
    required this.tamano})
      : super();

  @override
  Body createBody() {
    // TODO: implement createBody

    BodyDef definicionCuerpo= BodyDef(position: initialPosition,
        type: BodyType.dynamic,angularDamping: 0.8,userData: this);

    Body cuerpo= world.createBody(definicionCuerpo);


    final shape=CircleShape();
    shape.radius=tamano.x/2;

    FixtureDef fixtureDef=FixtureDef(
        shape,
        //density: 10.0,
        friction: 0.2,
        restitution: 0.5, userData: this
    );
    cuerpo.createFixture(fixtureDef);

    return cuerpo;
  }

  @override
  Future<void> onLoad() {
    // TODO: implement onLoad

    secondPlayer=SecondPlayer(position: Vector2(0,0),iTipo: iTipo,size:tamano);
    add(secondPlayer);
    return super.onLoad();
  }

  @override
  void onTapDown(_) {
    body.applyLinearImpulse(Vector2.random() * 5000);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // TODO: implement onKeyEvent

    final bool isKeyDown = event is RawKeyDownEvent;
    final bool isKeyUp = event is RawKeyUpEvent;
    //print("3333333---------->>>>>>>>>>>.   ${isKeyDown}     ${isKeyUp}");

    if(isKeyDown){
      horizontalDirection = 0;
      verticalDirection = 0;

      if(keysPressed.contains(LogicalKeyboardKey.arrowLeft)){
        horizontalDirection=-1;
      }
      else if(keysPressed.contains(LogicalKeyboardKey.arrowRight)){
        horizontalDirection=1;
      }


      if(keysPressed.contains(LogicalKeyboardKey.arrowUp)){
        verticalDirection=-1;
      }
      else if(keysPressed.contains(LogicalKeyboardKey.arrowDown)){
        verticalDirection=1;
      }

      /*if(keysPressed.contains(LogicalKeyboardKey.space)){
        if(blEspacioLiberado)jumpSpeed=2000;
        blEspacioLiberado=false;
        //body.gravityOverride=Vector2(0, -20);
        //this.bodyDef?.gravityOverride=Vector2(0, -20);
      }*/
    }
    /*else if(isKeyUp){
      //if(keysPressed.contains(LogicalKeyboardKey.space)){
      //print("222222222---------->>>>>>>>>>>.   ${blEspacioLiberado}");
      blEspacioLiberado=true;
      //}
    }*/
    return true;
  }



  @override
  void update(double dt) {
    // TODO: implement update

    velocidad.x = horizontalDirection * aceleracion;
    velocidad.y = verticalDirection * aceleracion;
    velocidad.y += -1 * jumpSpeed;
    jumpSpeed=0;

    // print("--------->>>>>>>>> ${velocidad}");
    //game.mapComponent.position -= velocity * dt;

    /**
     * IMPORTANTE! Para mover el personaje debemos APLICAR FUERZAS al CUERPO
     * NO mover las coordenadas usando el center ya que luego cuando el objeto REPOSA en el suelo,
     * este pasa a modo "dormido" y para despertarle DEBEMOS usar FUERZAS y no tocar el center.
     * Ver documentacion sobre BOX2D (https://www.iforce2d.net/b2dtut/forces)
     */
    //center.add((velocity * dt));
    body.applyLinearImpulse(velocidad*dt*1000);
    //body.applyAngularImpulse(3);

    if (horizontalDirection < 0 && secondPlayer.scale.x > 0) {
      //flipAxisDirection(AxisDirection.left);
      //flipAxis(Axis.horizontal);
      secondPlayer.flipHorizontallyAroundCenter();
    } else if (horizontalDirection > 0 && secondPlayer.scale.x < 0) {
      //flipAxisDirection(AxisDirection.left);
      secondPlayer.flipHorizontallyAroundCenter();
    }

    super.update(dt);
  }

}