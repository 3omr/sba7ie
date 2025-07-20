import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_report_factory/student_report_factory.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/widgets/student_report_by_teacher_widget.dart';

class StudentReportByTeacher extends StudentReportWidget {
  StudentReportByTeacher({required super.cubit});

  @override
  Widget build() {
    return StudentReportByTeacherWidget(cubit: cubit);
  }

  @override
  Decoration buildDecoration() => BoxDecoration(
      color: ColorManagement.mainBlue.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: ColorManagement.mainBlue));
}


