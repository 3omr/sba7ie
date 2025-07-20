import 'package:flutter/cupertino.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_report_factory/student_report_by_date_range.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_report_factory/student_report_by_teacher.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_report_by_date_range_cubit/student_report_by_date_range_cubit.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_report_by_teacher_cubit/student_reports_cubit.dart';

abstract class StudentReportWidget {
  final dynamic cubit;
  StudentReportWidget({required this.cubit});

  Widget build();

  Decoration buildDecoration() => const BoxDecoration();
}

class StudentReportFactory {
  static Widget buildWidget({
    required StudentReportsType type,
    StudentReportsCubit? studentReportsCubit,
    StudentReportByDateRangeCubit? dateRangeCubit,
  }) {
    switch (type) {
      case StudentReportsType.teacher:
        if (studentReportsCubit == null) {
          throw ArgumentError(
              'StudentReportsCubit is required for teacher reports');
        }
        return StudentReportByTeacher(cubit: studentReportsCubit).build();

      case StudentReportsType.dateRange:
        if (dateRangeCubit == null) {
          throw ArgumentError(
              'StudentReportByDateRangeCubit is required for date range reports');
        }
        return StudentReportByDateRange(cubit: dateRangeCubit).build();
    }
  }

  static Decoration? buildDecoration({
    required StudentReportsType type,
    required StudentReportsType buttonType,
    StudentReportsCubit? studentReportsCubit,
    StudentReportByDateRangeCubit? dateRangeCubit,
  }) {
    if (type != buttonType) return null;

    switch (type) {
      case StudentReportsType.teacher:
        return studentReportsCubit != null
            ? StudentReportByTeacher(cubit: studentReportsCubit)
                .buildDecoration()
            : const BoxDecoration();

      case StudentReportsType.dateRange:
        return dateRangeCubit != null
            ? StudentReportByDateRange(cubit: dateRangeCubit).buildDecoration()
            : const BoxDecoration();
    }
  }
}


enum StudentReportsType { teacher, dateRange }
