import 'package:flutter/material.dart';
import 'package:tasneem_sba7ie/utl/color_management.dart';
import 'package:tasneem_sba7ie/utl/text_management.dart';

class Header extends StatelessWidget {
  final String text;
  final double width;
  const Header({super.key, required this.text, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Center(
        child: Text(
          text,
          style: TextManagement.cairoS05W500White
              .copyWith(color: ColorManagement.deepBlue),
        ),
      ),
    );
  }
}
