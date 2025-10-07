import 'package:flutter/widgets.dart';

class SizeCofig {
  static double screenHeight = 0.0;
  static double screenWidth = 0.0;

  static void init(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }

  static double getProportionateHeight(double inputHeight) {
    return (inputHeight / 812) * screenHeight;
  }

  static double getProportionateWidth(double inputWidth) {
    return (inputWidth / 812) * screenWidth;
  }
}
