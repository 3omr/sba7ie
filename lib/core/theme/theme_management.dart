import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';

class ThemeManagement {
  static final ThemeData lightTheme = ThemeData(
      colorScheme: const ColorScheme.light(
        primary: ColorManagement.mainBlue,
        onPrimary: ColorManagement.mainBlue,
        secondary: ColorManagement.accentOrange,
        onSecondary: ColorManagement.white,
      ),
      scaffoldBackgroundColor: ColorManagement.lightGrey,

      // AppBar
      appBarTheme: AppBarTheme(
        titleTextStyle: TextManagement.alexandria20RegularBlack.copyWith(
          color: ColorManagement.mainBlue,
          fontWeight: FontWeight.w700,
        ),
        elevation: 0,
        foregroundColor: ColorManagement.mainBlue,
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: ColorManagement.mainBlue.withOpacity(0.2),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextManagement.alexandria16RegularDarkGrey,
        iconColor: ColorManagement.mainBlue,
        prefixIconColor: ColorManagement.mainBlue,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.transparent,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorManagement.mainBlue,
        foregroundColor: ColorManagement.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        backgroundColor: ColorManagement.mainBlue,
        padding: EdgeInsets.symmetric(
          horizontal: 32.w,
          vertical: 16.h,
        ),
        textStyle: TextManagement.alexandria16RegularWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 4,
        shadowColor: ColorManagement.darkGrey.withOpacity(0.3),
      )));
}
