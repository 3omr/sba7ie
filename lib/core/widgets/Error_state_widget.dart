import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';

class ErrorStateWidget extends StatelessWidget {
  final String text;
  final VoidCallback reloadFunction;
  const ErrorStateWidget({
    super.key,
    required this.text,
    required this.reloadFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            text,
            style: TextManagement.alexandria18RegularBlack,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {
              reloadFunction();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManagement.mainBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'إعادة المحاولة',
              style: TextManagement.alexandria16RegularWhite,
            ),
          ),
        ],
      ),
    );
  }
}
