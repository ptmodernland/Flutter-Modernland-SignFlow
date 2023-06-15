import 'dart:math';

import 'package:flutter/material.dart';

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 50, double maxFontSize = 25}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 800) * maxTextScaleFactor;
    double fontSize = max(1, min(val, maxTextScaleFactor));

    if (width > 500) {
      fontSize -= 9;
    }

    return min(fontSize, maxFontSize);
  }
}
