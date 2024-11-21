import 'package:flutter/material.dart';

class AppColor {
  static Color primary = Color(0xFFEE5A0A);
  static Color primarySoft = Color(0xFFEC7412);
  static Color primaryExtraSoft = Color(0xFF131212);
  static Color secondary = Color(0xFF232322);
  static Color whiteSoft = Color(0xFFF8F8F8);
  static LinearGradient bottomShadow = LinearGradient(colors: [Color(0xFF6E3302).withOpacity(0.2), Color(
      0xFFEC7412).withOpacity(0)], begin: Alignment.bottomCenter, end: Alignment.topCenter);
  static LinearGradient linearBlackBottom = LinearGradient(colors: [Colors.black.withOpacity(0.45), Colors.black.withOpacity(0)], begin: Alignment.bottomCenter, end: Alignment.topCenter);
  static LinearGradient linearBlackTop = LinearGradient(colors: [Colors.black.withOpacity(0.5), Colors.transparent], begin: Alignment.topCenter, end: Alignment.bottomCenter);
}
