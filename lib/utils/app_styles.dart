import 'package:doctor_finder/utils/size_config.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static final headingTextStyle = TextStyle(
    fontSize: SizeCofig.getProportionateHeight(20),
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontFamily: 'Madimi One',
  );

  static final titleTextStyle = TextStyle(
    fontSize: SizeCofig.getProportionateHeight(18),
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontFamily: 'Madimi One',
  );

  static final normalTextStyle = TextStyle(
    fontSize: SizeCofig.getProportionateHeight(15),
    color: Colors.white,
    fontWeight: FontWeight.w400,
    fontFamily: 'Madimi One',
  );

  static const mainColor = Color(0xFF1591EA);
}
