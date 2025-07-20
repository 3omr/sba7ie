import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/action_button.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_report_factory/student_report_factory.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_report_by_date_range_cubit/student_report_by_date_range_cubit.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_report_by_teacher_cubit/student_reports_cubit.dart';

class StudentReportsScreen extends StatefulWidget {
  const StudentReportsScreen({super.key});

  @override
  StudentReportsScreenState createState() => StudentReportsScreenState();
}

class StudentReportsScreenState extends State<StudentReportsScreen> {
  StudentReportsType selectedType = StudentReportsType.teacher;

  @override
  Widget build(BuildContext context) {
    final studentReportsCubit = context.read<StudentReportsCubit>();
    final studentReportByDateRangeCubit =
        context.read<StudentReportByDateRangeCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('تقارير الطلبة'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.03.sh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContainerShadow(
                child: Padding(
                  padding: EdgeInsets.all(0.02.sw),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("نوع التقرير",
                          style: TextManagement.alexandria18BoldMainBlue),
                      SizedBox(height: 0.02.sh),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedType = StudentReportsType.teacher;
                              });
                            },
                            child: Card(
                              elevation: 0,
                              color: Colors.transparent,
                              child: Container(
                                padding: EdgeInsets.all(0.02.sw),
                                decoration:
                                    StudentReportFactory.buildDecoration(
                                        studentReportsCubit:
                                            studentReportsCubit,
                                        dateRangeCubit:
                                            studentReportByDateRangeCubit,
                                        type: selectedType,
                                        buttonType: StudentReportsType.teacher),
                                child: const ActionButton(
                                  color: ColorManagement.mainBlue,
                                  icon: FontAwesomeIcons.userGraduate,
                                  label: 'عن طريق المعلم',
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedType = StudentReportsType.dateRange;
                              });
                            },
                            child: Card(
                              elevation: 0,
                              color: Colors.transparent,
                              child: Container(
                                padding: EdgeInsets.all(0.02.sw),
                                decoration:
                                    StudentReportFactory.buildDecoration(
                                        type: selectedType,
                                        studentReportsCubit:
                                            studentReportsCubit,
                                        dateRangeCubit:
                                            studentReportByDateRangeCubit,
                                        buttonType:
                                            StudentReportsType.dateRange),
                                child: const ActionButton(
                                  color: ColorManagement.accentOrange,
                                  icon: FontAwesomeIcons.calendar,
                                  label: 'عن طريق التاريخ',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 0.02.sh),
              Column(
                children: [
                  StudentReportFactory.buildWidget(
                      type: selectedType,
                      dateRangeCubit: studentReportByDateRangeCubit,
                      studentReportsCubit: studentReportsCubit),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
