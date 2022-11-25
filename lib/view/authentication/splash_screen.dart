import 'package:flutter/material.dart';
import 'package:kitapcim/constants/assets_constant.dart';
import 'package:kitapcim/constants/context_extentions.dart';
import 'package:kitapcim/view/authentication/login_register_view.dart';

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
          MaterialPageRoute(builder: (context) => EntryPageView()),
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
      child: Center(
          child: Image.asset(
        AssetsConstant.instance.logoImage,
        width: context.dynamicWidth(0.6),
        height: context.dynamicHeight(0.3),
      )),
    ));
  }
}
