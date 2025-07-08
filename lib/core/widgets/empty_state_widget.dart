import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';

class EmptyStateWidget extends StatelessWidget {
  final String text;
  final String addButtonText;
  final VoidCallback onPressed;
  const EmptyStateWidget({
    super.key,
    required this.text,
    required this.addButtonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off,
            color: ColorManagement.darkGrey,
            size: 64.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            text,
            style: TextManagement.alexandria20RegularBlack,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {
              onPressed();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManagement.mainBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              addButtonText,
              style: TextManagement.alexandria16RegularWhite,
            ),
          ),
        ],
      ),
    );
  }
}
