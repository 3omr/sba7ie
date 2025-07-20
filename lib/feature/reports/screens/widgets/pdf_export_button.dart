import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';

class PDFExportButton extends StatelessWidget {

  final VoidCallback? onTap;

  const PDFExportButton({
    super.key,
this.onTap,
  });

  @override
  Widget build(BuildContext context) {


    return ContainerShadow(
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: GestureDetector(
          onTap: 
           onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 16.w,
            ),
            decoration: BoxDecoration(
              color: ColorManagement.mainBlue,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.filePdf,
                  color: ColorManagement.white,
                  size: 24.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'تصدير كـ PDF',
                  style: TextManagement.alexandria16RegularWhite.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
