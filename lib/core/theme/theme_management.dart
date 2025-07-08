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
      appBarTheme: AppBarTheme(
        titleTextStyle: TextManagement.alexandria20RegularBlack,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: ColorManagement.mainBlue,
        centerTitle: true,
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
      ));
}
