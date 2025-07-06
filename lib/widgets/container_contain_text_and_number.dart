import 'package:flutter/material.dart';
import 'package:tasneem_sba7ie/utl/color_management.dart';
import 'package:tasneem_sba7ie/utl/contant.dart';
import 'package:tasneem_sba7ie/utl/text_management.dart';

class ContainerContainTextAndNumber extends StatelessWidget {
  final String text;
  final int number;
  const ContainerContainTextAndNumber(
      {super.key, required this.text, required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Utl.widthScreen * 0.02,
          vertical: Utl.heightScreen * 0.02),
      height: Utl.heightScreen * 0.15,
      width: Utl.widthScreen * 0.45,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: Colors.grey[200]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text,
              style: TextManagement.cairoS05W500White
                  .copyWith(color: ColorManagement.deepPurple)),
          Text("$number",
              style: TextManagement.cairoS05W500White
                  .copyWith(color: ColorManagement.deepBlue))
        ],
      ),
    );
  }
}
