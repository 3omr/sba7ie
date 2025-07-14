import 'package:flutter/material.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';

class AppSnackBars {
  static void showSuccessSnackBar(
      {required BuildContext context, required String successMsg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          successMsg,
          style: TextManagement.alexandria16RegularWhite,
        ),
        backgroundColor: ColorManagement.mainBlue,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static void showErrorSnackBar(
      {required BuildContext context, required String errorMsg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          errorMsg,
          style: TextManagement.alexandria16RegularWhite,
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
