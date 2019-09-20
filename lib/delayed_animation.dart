import 'dart:async';
import 'package:flutter/material.dart';

class DelayedAnimation extends StatefulWidget {
  DelayedAnimation({Key key, this.child, this.delayed}) : super(key: key);
  final Widget child;
  final int delayed;

  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation> 
  with TickerProviderStateMixin {
  
  AnimationController _controller;
  Animation<Offset> _animOffset;

  @override
  void initState() { 
    super.initState();
    _controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    final curve =
      CurvedAnimation(curve: Curves.decelerate, parent: _controller);
    _animOffset =
      Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
        .animate(curve);

    if (widget.delayed == null){
      _controller.forward();
    } else {
      Timer(Duration(milliseconds: widget.delayed), (){
        _controller.forward();
      });
    }
  }

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _controller,
    );
  }
}