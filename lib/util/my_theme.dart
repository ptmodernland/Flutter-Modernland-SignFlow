import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modernland_signflow/util/my_colors.dart';

class MyTheme {
  // Color Constants
  static const Color primaryTextColor = AppColors.primaryTextColor;
  static const Color secondaryTextColor = AppColors.secondaryTextColor;
  static const Color accentColor = AppColors.accentColor;

  // Font Styles
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;

  // Text Styles
  static final TextStyle myStylePrimaryTextStyle = GoogleFonts.poppins(
    fontWeight: regular,
    fontSize: 16.0,
    color: AppColors.primaryColor2,
  );

  static TextStyle myStyleSecondaryTextStyle = GoogleFonts.poppins(
    fontWeight: light,
    fontSize: 14.0,
    color: AppColors.secondaryTextColor,
  );

  static TextStyle myStyleAccentTextStyle = GoogleFonts.poppins(
    fontWeight: medium,
    fontSize: 14.0,
    color: AppColors.accentColor,
  );

  static TextStyle myStyleButtonTextStyle = GoogleFonts.lato();
}