import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

enum AnimationType { opacity, translateX }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AnimationType>()
      ..add(AnimationType.opacity, Tween(begin: 0.0, end: 1.0),
        Duration(milliseconds: 500),)
      ..add(
        AnimationType.translateX,
        Tween(begin: 30.0, end: 1.0),
        Duration(milliseconds: 500),
      );

    return PlayAnimation<MultiTweenValues<AnimationType>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AnimationType.opacity),
        child: Transform.translate(
            offset: Offset(value.get(AnimationType.translateX), 0), child: child),
      ),
    );
  }
}

class BouncyPage extends PageRouteBuilder{
  final Widget widget;
  final Curve curve;
  BouncyPage({required this.widget,required this.curve}) : super(
    transitionDuration: Duration(milliseconds: 900),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      animation=CurvedAnimation(parent: animation, curve: curve);
      return  ScaleTransition(
        scale: animation,
        alignment: Alignment.center,
        child: child,
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) => widget,

  );
}