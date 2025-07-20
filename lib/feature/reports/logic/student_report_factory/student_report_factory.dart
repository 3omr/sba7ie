import 'package:flutter/cupertino.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_report_factory/student_report_by_date_range.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_report_factory/student_report_by_teacher.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_reports_cubit.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_reports_state.dart';

abstract class StudentReportWidget {
  final StudentReportsCubit cubit;
  StudentReportWidget({required this.cubit});

  Widget build();

  Decoration buildDecoration() => const BoxDecoration();
}

extension StudentReportWidgetFactory on StudentReportWidget {
  static Widget buildWidget(
      {required StudentReportsType type,
      required StudentReportsCubit cubit,
      required BuildContext context}) {
    switch (type) {
      case StudentReportsType.teacher:
        return StudentReportByTeacher(cubit: cubit).build();
      case StudentReportsType.dateRange:
        return StudentReportByDateRange(cubit: cubit, context: context).build();
    }
  }

  static Decoration? buildDecoration(
      {required StudentReportsType type,
      required StudentReportsCubit cubit,
      required StudentReportsType buttonType}) {
    switch (type) {
      case StudentReportsType.teacher:
        return buttonType == StudentReportsType.teacher
            ? StudentReportByTeacher(cubit: cubit).buildDecoration()
            : null;
      case StudentReportsType.dateRange:
        return buttonType == StudentReportsType.dateRange
            ? StudentReportByDateRange(cubit: cubit).buildDecoration()
            : null;
    }
  }
}
