import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';

class HomeScreenSection extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const HomeScreenSection({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(horizontal: 0.02.sw),
        decoration: BoxDecoration(
          color: ColorManagement.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: ColorManagement.mainBlue.withOpacity(0.15),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              icon,
              size: 36.sp,
              color: ColorManagement.mainBlue,
            ),
            SizedBox(height: 10.h),
            Text(
              text,
              style: TextManagement.alexandria18RegularBlack,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
