

import 'package:flutter/material.dart';

class ScreenUtil {
  static double getScreenHeight(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return screenHeight;
  }

  static double getScreenWidth(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;
    return screenHeight;
  }
}