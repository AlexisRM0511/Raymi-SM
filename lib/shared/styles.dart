import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Styles {
  static textStyle(double size) {
    return TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);
  }

  static background() {
    return const BoxDecoration(color: Color(0xFFEFEFEF));
  }
}
