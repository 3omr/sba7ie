import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_report_factory/student_report_factory.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/widgets/teacher_dropdown.dart';

class StudentReportByTeacher extends StudentReportWidget {
  StudentReportByTeacher({required super.cubit});

  @override
  Widget build() {
    return Column(
      children: [
        cubit.teachers.isEmpty
            ? const SizedBox.shrink()
            : TeacherDropdown(
                teachers: cubit.teachers,
                selectedTeacherId: cubit.selectedTeacherId,
                onChanged: (value) {
                  if (value != null) {
                    cubit.selectedTeacherId = value;

                    cubit.getStudentReportsByTeacherID(value);
                  }
                },
              )
      ],
    );
  }

  @override
  Decoration buildDecoration() => BoxDecoration(
      color: ColorManagement.mainBlue.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: ColorManagement.mainBlue));
}
