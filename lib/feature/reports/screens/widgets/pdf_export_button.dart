import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasneem_sba7ie/core/router/pdf_generator_helper.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/student_report.dart';

class PDFExportButton extends StatelessWidget {
  final String teacherName;
  final List<StudentReport> students;

  const PDFExportButton({
    super.key,
    required this.teacherName,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    if (students.isEmpty) {
      return const SizedBox.shrink();
    }

    return ContainerShadow(
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: GestureDetector(
          onTap: () {
            PDFGeneratorHelper.generateStudentsByTeacherPDF(
              context,
              teacherName,
              students,
            );
          },
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
