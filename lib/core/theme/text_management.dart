import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';

class TextManagement {
  // Alexandria Font Styles
  static TextStyle alexandria14RegularDarkGrey = GoogleFonts.alexandria(
    fontSize: 14.0.sp,
    fontWeight: FontWeight.w400,
    color: ColorManagement.darkGrey.withOpacity(0.5),
  );

  static TextStyle alexandria16RegularBlack = GoogleFonts.alexandria(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w400,
    color: ColorManagement.black,
  );
  static TextStyle alexandria16RegularWhite = GoogleFonts.alexandria(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w400,
    color: ColorManagement.white,
  );
  static TextStyle alexandria16RegularLightGrey = GoogleFonts.alexandria(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w400,
    color: ColorManagement.lightGrey,
  );
  static TextStyle alexandria16RegularDarkGrey = GoogleFonts.alexandria(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w400,
    color: ColorManagement.darkGrey.withOpacity(0.5),
  );
  static TextStyle alexandria16BoldMainBlue = GoogleFonts.alexandria(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w600,
    color: ColorManagement.mainBlue,
  );

  static TextStyle alexandria18RegularBlack = GoogleFonts.alexandria(
    fontSize: 18.0.sp,
    fontWeight: FontWeight.w400,
    color: ColorManagement.black,
  );
  static TextStyle alexandria18BoldMainBlue = GoogleFonts.alexandria(
    fontSize: 18.0.sp,
    fontWeight: FontWeight.w600,
    color: ColorManagement.mainBlue,
  );
  static TextStyle alexandria20RegularBlack = GoogleFonts.alexandria(
    fontSize: 20.0.sp,
    fontWeight: FontWeight.w400,
    color: ColorManagement.black,
  );
  static TextStyle alexandria24BoldBlack = GoogleFonts.alexandria(
    fontSize: 24.0.sp,
    fontWeight: FontWeight.w700,
    color: ColorManagement.black,
  );

  // Lalezar Font Styles
  static TextStyle lalezar16RegularBlack = GoogleFonts.lalezar(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w400,
    color: ColorManagement.black,
  );
  static TextStyle lalezar18RegularBlack = GoogleFonts.lalezar(
    fontSize: 18.0.sp,
    fontWeight: FontWeight.w400,
    color: ColorManagement.black,
  );
  static TextStyle lalezar20RegularBlack = GoogleFonts.lalezar(
    fontSize: 20.0.sp,
    fontWeight: FontWeight.w400,
    color: ColorManagement.black,
  );
  static TextStyle lalezar24BoldBlack = GoogleFonts.lalezar(
    fontSize: 24.0.sp,
    fontWeight: FontWeight.w700,
    color: ColorManagement.black,
  );

  static TextStyle lalezar24BoldOrange = GoogleFonts.lalezar(
    fontSize: 24.0.sp,
    fontWeight: FontWeight.w700,
    color: ColorManagement.accentOrange,
  );

  // Ruwudu Font Styles

  // this font is used for the main title in the home screen
  static TextStyle ruwudu30BoldWhite = GoogleFonts.ruwudu(
    fontSize: 30.sp,
    fontWeight: FontWeight.bold,
    color: ColorManagement.white,
  );
}
