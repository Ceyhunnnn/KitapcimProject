import 'package:flutter/material.dart';

class PaddingConstant {
  static PaddingConstant instance = PaddingConstant._init();
  PaddingConstant._init();

  final paddingLow = EdgeInsets.all(8);
  final paddingNormal = EdgeInsets.all(16);
  final paddingHight = EdgeInsets.all(20);
}
//class tarafında kullanımı 
// PaddingConstants.instance.paddingNormal, 