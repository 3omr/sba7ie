import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';

class CategoriesList extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const CategoriesList({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 0.45.sw,
        height: 80.h,
        decoration: BoxDecoration(
          color: ColorManagement.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: ColorManagement.darkGrey,
              blurRadius: 10.r,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: ColorManagement.lightGrey,
            width: 1.w,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 60.w,
              height: 60.h,
              // margin: EdgeInsets.symmetric(horizontal: 8.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    ColorManagement.mainBlue,
                    ColorManagement.lightGrey,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: ColorManagement.white,
                  size: 28.sp,
                ),
              ),
            ),
            Text(
              text,
              style: TextManagement.alexandria16RegularBlack.copyWith(
                color: ColorManagement.darkGrey,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
