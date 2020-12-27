import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class AnimationWidget extends StatefulWidget {
  final Widget child;
  final int duration;
  final Function additionalFunHandler;

  AnimationWidget({this.child, this.duration, this.additionalFunHandler});

  _AnimationWidgetState createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;

  Animation<double> _animation;
  Timer _timer;

  void _runAnimation() {
    if (widget.additionalFunHandler != null) {
      widget.additionalFunHandler();
    }

    _controller.reset();

    _controller.forward();
  }

  void _setTimer() {
    _timer = Timer.periodic(
      Duration(milliseconds: widget.duration),
      (Timer t) => _runAnimation(),
    );
  }

  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    _controller.forward();
    _setTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        key: UniqueKey(),
        opacity: _animation,
        child: widget.child,
      ),
    );
  }
}
