import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'delayed_animation.dart';

void main(){
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> 
  with SingleTickerProviderStateMixin {

  final int delayedAmount = 500;
  double _scale;
  AnimationController _controller;  
  
  @override
  void initState() { 
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener((){
        setState(() {});
    });
    super.initState();
  }

  Widget _avatarGlow(){
    return AvatarGlow(
      endRadius: 90,
      duration: Duration(seconds: 2),
      glowColor: Colors.white24,
      repeat: true,
      repeatPauseDuration: Duration(seconds: 2),
      startDelay: Duration(seconds: 1),
      child: Material(
        elevation: 8.0,
        shape: CircleBorder(),
        child: CircleAvatar(
          backgroundColor: Colors.grey[100],
          child: FlutterLogo(
            size: 50.0,
          ),
          radius: 50.0,
        ),
      ),
    );
  }

  Widget _firstText(Color color){
    return DelayedAnimation(
      child: Text(
        'Hola!',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 36.0,
          color: color
        )
      ),
      delayed: delayedAmount + 1000,
    );
  }

  Widget _secondText(Color color){
    return DelayedAnimation(
      child: Text(
        'Soy un login',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 36.0,
          color: color
        )
      ),
      delayed: delayedAmount + 2000,
    );
  }

  Widget _thirdText(Color color){
    return DelayedAnimation(
      child: Text(
        'Tu nuevo compañero',
        style: TextStyle(
          fontSize: 20.0,
          color: color
        )
      ),
      delayed: delayedAmount + 3000,
    );
  }

  Widget _boton(var _scale){
    return DelayedAnimation(
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        child: Transform.scale(
          scale: _scale,
          child: _animatedButtonUI,
        ),
      ),
      delayed: delayedAmount + 4000,
    );
  }

  Widget get _animatedButtonUI => Container(
    height: 60,
    width: 270,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Colors.white,
    ),
    child: Center(
      child: Text(
        'Iniciar',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0xff8185e2)
        ),
      ),
    ),
  );

  void _onTapDown(TapDownDetails details){
    _controller.forward();
  }
  void _onTapUp(TapUpDetails details){
    _controller.reverse();
  }
  @override
  Widget build(BuildContext context) {
    final color = Colors.white;
    _scale = 1 - _controller.value;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xff8185e2),
        body: Center(
          child: Column(
            children: <Widget>[
              _avatarGlow(),
              _firstText(color),
              _secondText(color),
              SizedBox(height: 30.0,),
              _thirdText(color),
              SizedBox(height: 100,),
              _boton(_scale)
            ],
          ),
        ),
      ),
    );
  }
}

