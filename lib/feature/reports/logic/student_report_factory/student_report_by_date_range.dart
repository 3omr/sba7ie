import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_report_factory/student_report_factory.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/widgets/student_report_by_date_range_widget.dart';

class StudentReportByDateRange extends StudentReportWidget {
  StudentReportByDateRange({required super.cubit});

  @override
  Widget build() => StudentReportByDateRangeWidget(cubit: cubit);

  @override
  Decoration buildDecoration() => BoxDecoration(
      color: ColorManagement.accentOrange.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: ColorManagement.accentOrange));
}

