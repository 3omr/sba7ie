import 'package:flutter/material.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';

class ThemeManagement {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: ColorManagement.mainBlue,
      onPrimary: ColorManagement.mainBlue,
      secondary: ColorManagement.accentOrange,
      onSecondary: ColorManagement.white,
    ),
    scaffoldBackgroundColor: ColorManagement.lightGrey,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: ColorManagement.mainBlue,
      centerTitle: true,
    ),
  );
}
