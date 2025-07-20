import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/helper/pdf_generator_helper.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_report_by_teacher_cubit/student_reports_cubit.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_report_by_teacher_cubit/student_reports_state.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/widgets/pdf_export_button.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/widgets/student_report_table.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/widgets/teacher_dropdown.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';

class StudentReportByTeacherWidget extends StatelessWidget {
  const StudentReportByTeacherWidget({
    super.key,
    required this.cubit,
  });

  final StudentReportsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentReportsCubit, StudentReportsState>(
      builder: (context, state) {
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
                  ),
            SizedBox(height: 0.02.sh),
            if (cubit.studentReports.isNotEmpty)
              Column(
                children: [
                  StudentReportTable(
                    studentReports: cubit.studentReports,
                  ),
                  SizedBox(height: 0.02.sh),
                  PDFExportButton(
                    onTap: () =>
                        PDFGeneratorHelper.generateStudentsByTeacherPDF(
                      context,
                      cubit.teachers
                              .firstWhere(
                                (t) => t.id == cubit.selectedTeacherId,
                                orElse: () => Teacher(id: -1, name: ''),
                              )
                              .name ??
                          '',
                      cubit.studentReports,
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
