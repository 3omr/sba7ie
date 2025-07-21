import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tasneem_sba7ie/core/helper/pdf_generator_helper.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/Error_state_widget.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/teacher_reports_cubit/teacher_reports_cubit.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/teacher_reports_cubit/teacher_reports_state.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/widgets/pdf_export_button.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/widgets/teacher_choose_month.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/widgets/teacher_salary_report_table.dart';

class TeacherReportsScreen extends StatelessWidget {
  const TeacherReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('تقارير المعلمين'),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.03.sh),
          child: Column(
            children: [
              ContainerShadow(
                child: Padding(
                  padding: EdgeInsets.all(0.02.sw),
                  child: TeacherChooseMonth(
                      cubit: context.watch<TeacherReportsCubit>()),
                ),
              ),
              SizedBox(height: 0.02.sh),
              BlocBuilder<TeacherReportsCubit, TeacherReportsState>(
                builder: (context, state) {
                  if (state is TeacherReportsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is TeacherReportsLoaded) {
                    return Column(
                      children: [
                        TeacherSalaryReportTable(
                          monthYear:
                              context.watch<TeacherReportsCubit>().currentDate,
                          teacherReports: context
                              .read<TeacherReportsCubit>()
                              .teachersReport,
                        ),
                        SizedBox(height: 0.02.sh),
                        PDFExportButton(
                            onTap: () => PDFGeneratorHelper
                                .generateTeacherSalaryReportPDF(
                                    context,
                                    context
                                        .read<TeacherReportsCubit>()
                                        .teachersReport,
                                    DateFormat('MM-yyyy')
                                        .format(context
                                            .read<TeacherReportsCubit>()
                                            .currentDate)
                                        .toString()))
                      ],
                    );
                  } else if (state is TeacherReportsError) {
                    return ErrorStateWidget(
                      text: state.error,
                      reloadFunction: () {
                        context
                            .read<TeacherReportsCubit>()
                            .getTeacherSalaryReportForMonth(
                                DateFormat('MM-yyyy')
                                    .format(context
                                        .read<TeacherReportsCubit>()
                                        .currentDate)
                                    .toString());
                      },
                    );
                  } else if (state is TeacherReportsEmpty) {
                    return const ContainerShadow(
                        child: Text(
                      'لا يوجد تقارير لهذا الشهر',
                    ));
                  }
                  return ContainerShadow(
                      child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Text(
                      "قم باختيار الشهر لعرض التقارير",
                      style: TextManagement.alexandria16RegularBlack,
                    ),
                  ));
                },
              ),
            ],
          ),
        )));
  }
}
