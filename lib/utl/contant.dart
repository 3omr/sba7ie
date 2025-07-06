import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utl {
  static double widthScreen = Get.width;
  static double heightScreen = Get.height;

  static void dialogWindow(
      {required String title,
      required String msg,
      required String buttonText,
      required VoidCallback onPressed}) {
    Get.defaultDialog(
        title: title,
        content: Text(msg),
        cancel: ElevatedButton(
          onPressed: onPressed,
          child: Text(buttonText),
        ));
  }
}
