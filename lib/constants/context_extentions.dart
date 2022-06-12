import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension TextExtension on BuildContext {
  Text kapsulTitleFont(
          String title, FontWeight fontWeight, double fontSize, Color color) =>
      Text(
        title,
        style: TextStyle(
            fontFamily: "Nasalization",
            fontWeight: fontWeight,
            fontSize: fontSize,
            color: color),
      );

  Text kapsulSubtitleFont(String text, TextAlign align, double spacing,
          Color color, double fontSize) =>
      Text(text,
          textAlign: align,
          style: GoogleFonts.roboto(
              letterSpacing: spacing, color: color, fontSize: fontSize));
}

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

extension ColorExtension on BuildContext {
  Color get linkWater => Color(0xffe0eaf7).withOpacity(0.9);
  Color get royalBlue => Color(0xff3d71f1).withOpacity(0.9);
  Color get curiousBlue => Color(0xff21A9E1);
  Color get dodgerBlue => Color(0xff4d80fd).withOpacity(0.45);
  Color get onahau => Color(0xffc8e0ff).withOpacity(0.9);
  Color get cobaltBold => Color(0xff0040b5).withOpacity(0.9);
  Color get cobaltSoft => Color(0xff0047bd).withOpacity(0.9);
  Color get backgroundStart => Color(0xff0E0B28);
  Color get backgroundEnd => Color(0xff2DAAE1);
  Color get concrete => Color(0xffF3F3F3);
  Color get haiti => Color(0xFF0E0B28);
  Color get ironsideGray => Color(0xff61605F);
  Color get pippin => Color(0xFFE0E0E0);
  Color get dune => Color(0xff292624);
  Color get dawn => Color(0xffA09F9E);
  Color get amaranth => Color(0xffE52D50);
  Color get pictonBlue => Color(0xff2DAAE1);
  Color get scorpion => Color(0xff5E5E5E);
}

extension PaddingExtension on BuildContext {
  EdgeInsets get paddingAll => EdgeInsets.all(16.0);
  EdgeInsets get paddingLeft => EdgeInsets.only(left: 16.0);
  EdgeInsets get paddingRight => EdgeInsets.only(right: 16.0);
  EdgeInsets get paddingTop => EdgeInsets.only(top: 16.0);
  EdgeInsets get paddingBottom => EdgeInsets.only(bottom: 16.0);
  EdgeInsets get paddingHorizontal => EdgeInsets.symmetric(horizontal: 16.0);
  EdgeInsets get paddingVertical => EdgeInsets.symmetric(vertical: 16.0);
  EdgeInsets get paddingVerticalLow =>
      EdgeInsets.symmetric(vertical: dynamicWidth(0.1));
  EdgeInsets get paddingHorizontalLow =>
      EdgeInsets.symmetric(horizontal: dynamicWidth(0.1));
  EdgeInsets get paddingNormal => EdgeInsets.all(dynamicWidth(0.15));
  EdgeInsets get paddingHigh => EdgeInsets.all(dynamicWidth(0.2));
}

extension RadiusExtension on BuildContext {
  BorderRadius get borderRadius24 => BorderRadius.all(Radius.circular(24.0));
  BorderRadius get borderRadius16 => BorderRadius.all(Radius.circular(16.0));
  BorderRadius get borderRadius8 => BorderRadius.all(Radius.circular(8.0));
  BorderRadius get borderRadius4 => BorderRadius.all(Radius.circular(4.0));
}

extension ShadowDecoration on BuildContext {
  BoxDecoration shadowDecotation(Color color) => BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3))
      ], borderRadius: this.borderRadius8, color: color);
  BoxDecoration postShadowDecoration(Color color) => BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 3))
      ], borderRadius: this.borderRadius16, color: color);
}
