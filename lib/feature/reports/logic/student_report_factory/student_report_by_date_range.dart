import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/helper/pdf_generator_helper.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_report_factory/student_report_factory.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/widgets/date_range_picker.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/widgets/pdf_export_button.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/widgets/student_payment_table.dart';

class StudentReportByDateRange extends StudentReportWidget {
  final BuildContext? context;
  StudentReportByDateRange({required super.cubit, this.context});

  @override
  Widget build() => Column(children: [
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
                    context!, cubit.studentPayments),
              ),
            ],
          ),
      ]);

  @override
  Decoration buildDecoration() => BoxDecoration(
      color: ColorManagement.accentOrange.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: ColorManagement.accentOrange));
}
