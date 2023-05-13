import 'package:bwa_cozy/util/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  // Color Constants
  static const Color primaryTextColor = AppColors.primaryTextColor;
  static const Color secondaryTextColor = AppColors.secondaryTextColor;
  static const Color accentColor = AppColors.accentColor;

  // Font Styles
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;

  // Text Styles
  static TextStyle primaryTextStyle = GoogleFonts.poppins(
    fontWeight: bold,
    fontSize: 16.0,
    color: AppColors.textIconsColor,
  );

  static TextStyle secondaryTextStyle = GoogleFonts.poppins(
    fontWeight: medium,
    fontSize: 14.0,
    color: AppColors.textIconsColor,
  );

  static TextStyle accentTextStyle = GoogleFonts.poppins(
    fontWeight: medium,
    fontSize: 14.0,
    color: AppColors.accentColor,
  );

  static TextStyle buttonTextStyle = GoogleFonts.poppins(
    fontWeight: bold,
    fontSize: 16.0,
    color: AppColors.textIconsColor,
  );
}