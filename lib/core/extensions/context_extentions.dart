import 'package:flutter/material.dart';

extension ScreenExtension on BuildContext {
  double dynamicWidth(double val) => MediaQuery.of(this).size.width * val;
  double dynamicHeight(double val) => MediaQuery.of(this).size.height * val;
}

extension buildColor on BuildContext {
  Color get appColor => Color(0xff05595B);
}

extension buildDecoration on BuildContext {
  Decoration get contDecoration => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), topRight: Radius.circular(30)));
}

extension customText on BuildContext {
  TextStyle customTextStyle(color, size) => Theme.of(this)
      .textTheme
      .displaySmall!
      .copyWith(color: color, fontSize: size, fontWeight: FontWeight.w300);
}

extension customBackground on BuildContext {
  Decoration get customBackgroundStyle => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xff05595B),
            Color.fromARGB(255, 156, 53, 45),
          ],
        ),
      );
}
