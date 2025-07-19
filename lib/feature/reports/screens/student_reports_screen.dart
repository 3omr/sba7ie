import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasneem_sba7ie/core/router/pdf_generator_helper.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/action_button.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/student_report.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_report_factory/student_report_factory.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_reports_cubit.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_reports_state.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';

class StudentReportsScreen extends StatefulWidget {
  const StudentReportsScreen({super.key});

  @override
  _StudentReportsScreenState createState() => _StudentReportsScreenState();
}

class _StudentReportsScreenState extends State<StudentReportsScreen> {
  int? selectedTeacherId;

  StudentReportsType selectedType = StudentReportsType.teacher;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentReportsCubit, StudentReportsState>(
      builder: (context, state) {
        final cubit = context.read<StudentReportsCubit>();
        final teachers = cubit.teachers;
        final List<StudentReport> filteredStudents = selectedTeacherId == null
            ? []
            : cubit.studentReports
                .where((student) => student.teacherId == selectedTeacherId)
                .toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('تقارير الطلبة'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.03.sh),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // _HeaderSection(),

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
                                    decoration: StudentReportWidgetFactory
                                        .buildDecoration(
                                            cubit: cubit,
                                            type: selectedType,
                                            buttonType:
                                                StudentReportsType.teacher),
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
                                    decoration: StudentReportWidgetFactory
                                        .buildDecoration(
                                            type: selectedType,
                                            cubit: cubit,
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
                      StudentReportWidgetFactory.buildWidget(
                          type: selectedType, cubit: cubit),
                    ],
                  )

                  // SizedBox(height: 0.02.sh),
                  // _ReportContent(
                  //   state: state,
                  //   filteredStudents: filteredStudents,
                  // ),
                  // SizedBox(height: 0.02.sh),
                  // _PDFExportButton(
                  //   selectedTeacherId: selectedTeacherId,
                  //   teachers: teachers,
                  //   filteredStudents: filteredStudents,
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ReportContent extends StatelessWidget {
  final StudentReportsState state;
  final List<StudentReport> filteredStudents;

  const ReportContent({
    super.key,
    required this.state,
    required this.filteredStudents,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerShadow(
      child: state is StudentReportsLoading
          ? const Center(child: CircularProgressIndicator())
          : filteredStudents.isEmpty && state is! StudentReportsError
              ? _buildEmptyState('اختر معلمًا لعرض بيانات الطلبة')
              : state is StudentReportsError
                  ? _buildErrorState("حدث خطأ أثناء تحميل البيانات")
                  : state is StudentReportsEmpty
                      ? _buildEmptyState('لا توجد بيانات للطلبة لهذا المعلم')
                      : _buildStudentList(filteredStudents),
    );
  }

  Widget _buildEmptyState(String message) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: ColorManagement.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.infoCircle,
            color: ColorManagement.darkGrey.withOpacity(0.5),
            size: 32.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            message,
            style: TextManagement.alexandria16RegularBlack.copyWith(
              color: ColorManagement.darkGrey.withOpacity(0.5),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: ColorManagement.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.exclamationTriangle,
            color: ColorManagement.accentOrange,
            size: 32.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            message,
            style: TextManagement.alexandria16RegularBlack.copyWith(
              color: ColorManagement.accentOrange,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStudentList(List<StudentReport> students) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: students.length,
      itemBuilder: (context, index) {
        final student = students[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          child: Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: ColorManagement.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: ColorManagement.mainBlue.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name,
                  style: TextManagement.alexandria18RegularBlack.copyWith(
                    color: ColorManagement.mainBlue,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.h),
                _InfoRow(
                  icon: FontAwesomeIcons.moneyBill1Wave,
                  label: 'الاشتراك',
                  value: '${student.subscription} جنيه',
                  color: ColorManagement.mainBlue,
                ),
                SizedBox(height: 8.h),
                _InfoRow(
                  icon: FontAwesomeIcons.coins,
                  label: 'المدفوع',
                  value: '${student.totalPaid} جنيه',
                  color: ColorManagement.accentOrange,
                ),
                SizedBox(height: 8.h),
                _InfoRow(
                  icon: FontAwesomeIcons.wallet,
                  label: 'المتبقي',
                  value: '${student.remaining} جنيه',
                  color: ColorManagement.darkGrey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(
          icon,
          color: color,
          size: 20.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          '$label: ',
          style: TextManagement.alexandria16RegularBlack.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextManagement.alexandria16RegularBlack.copyWith(
              color: color,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

class PDFExportButton extends StatelessWidget {
  final int? selectedTeacherId;
  final List<Teacher> teachers;
  final List<StudentReport> filteredStudents;

  const PDFExportButton({
    super.key,
    required this.selectedTeacherId,
    required this.teachers,
    required this.filteredStudents,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedTeacherId == null || filteredStudents.isEmpty) {
      return const SizedBox.shrink();
    }

    return ContainerShadow(
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: GestureDetector(
          onTap: () {
            final teacher = teachers.firstWhere(
              (t) => t.id == selectedTeacherId,
              orElse: () => Teacher(id: -1, name: ''),
            );
            PDFGeneratorHelper.generateStudentsByTeacherPDF(
              context,
              teacher,
              filteredStudents,
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 16.w,
            ),
            decoration: BoxDecoration(
              color: ColorManagement.mainBlue,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.filePdf,
                  color: ColorManagement.white,
                  size: 24.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'تصدير كـ PDF',
                  style: TextManagement.alexandria16RegularWhite.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
