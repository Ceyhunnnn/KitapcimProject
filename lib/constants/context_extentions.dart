import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension ScreenExtension on BuildContext {
  double dynamicWidth(double val) => MediaQuery.of(this).size.width * val;
  double dynamicHeight(double val) => MediaQuery.of(this).size.height * val;
}

extension buildText on BuildContext {
  TextStyle buildTextStyle(double fontSize, Color color) {
    return GoogleFonts.comfortaa(fontSize: fontSize, color: color);
  }
}

extension buildColor on BuildContext {
  Color get appColor => Color(0xff05595B);
}
