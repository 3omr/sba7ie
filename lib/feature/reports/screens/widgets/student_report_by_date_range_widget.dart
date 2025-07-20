import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/helper/pdf_generator_helper.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_report_by_date_range_cubit/student_report_by_date_range_cubit.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_report_by_date_range_cubit/student_report_by_date_range_state.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/widgets/date_range_picker.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/widgets/pdf_export_button.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/widgets/student_payment_table.dart';

class StudentReportByDateRangeWidget extends StatelessWidget {
  const StudentReportByDateRangeWidget({
    super.key,
    required this.cubit,
  });

  final StudentReportByDateRangeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentReportByDateRangeCubit,
        StudentReportByDateRangeState>(
      builder: (context, state) {
        return Column(children: [
          DateRangePicker(
            cubit: cubit,
          ),
          SizedBox(height: 0.02.sh),
          if (cubit.studentPayments.isNotEmpty)
            Column(
              children: [
                StudentPaymentTable(studentPayments: cubit.studentPayments),
                SizedBox(height: 0.02.sh),
                PDFExportButton(
                  onTap: () => PDFGeneratorHelper.generateAllStudentPaymentsPDF(
                      context, cubit.studentPayments),
                ),
              ],
            ),
        ]);
      },
    );
  }
}
