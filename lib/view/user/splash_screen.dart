import 'package:flutter/material.dart';

import 'entry_view.dart';

class ScaleTransitionScreen extends StatefulWidget {
  @override
  ScaleTransitionScreenState createState() => ScaleTransitionScreenState();
}

class ScaleTransitionScreenState extends State<ScaleTransitionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => EntryPage()),
          (Route<dynamic> route) => false);
    });
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _scale = Tween<double>(begin: 0.0, end: 1).animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ScaleTransition(
      scale: _scale,
      child: Center(child: Image.asset("assets/images/logo.png")),
    ));
  }
}
