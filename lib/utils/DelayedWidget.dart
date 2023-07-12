import 'dart:async';
import 'package:flutter/material.dart';

class DelayedWidget extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final int duration;

  const DelayedWidget({
    Key? key,
    required this.child,
    this.delay = const Duration(seconds: 1),
    this.duration = 500,
  }) : super(key: key);

  @override
  _DelayedWidgetState createState() => _DelayedWidgetState();
}

class _DelayedWidgetState extends State<DelayedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    Timer(widget.delay, () {
      setState(() {
        _visible = true;
        _controller.forward();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: widget.duration),
      opacity: _visible ? 1.0 : 0.0,
      child: FadeTransition(
        opacity: _animation,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
