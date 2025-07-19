import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasneem_sba7ie/core/router/pdf_generator_helper.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/student_report.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_report_factory/student_report_factory.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/widgets/teacher_dropdown.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';

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
              ),
        SizedBox(height: 0.02.sh),
        if (cubit.studentReports.isNotEmpty)
          SizedBox(
            height: 0.4.sh,
            child: ContainerShadow(
              child: Padding(
                padding: EdgeInsets.all(16.sp),
                child: Column(
                  children: [
                    // Header Row (Optional, if you want a fixed header above the scrollable list)
                    _buildHeaderRow(),
                    SizedBox(height: 8.sp), // Spacing between header and list
                    Expanded(
                      child: ListView.builder(
                        itemCount: cubit.studentReports.length,
                        itemBuilder: (context, index) {
                          final student = cubit.studentReports[index];
                          return _buildStudentReportCard(student);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        SizedBox(height: 0.02.sh),
        PDFExportButton(
          students: cubit.studentReports,
          teacherName: cubit.teachers
                  .firstWhere(
                    (t) => t.id == cubit.selectedTeacherId,
                    orElse: () => Teacher(id: -1, name: ''),
                  )
                  .name ??
              '',
        ),
      ],
    );
  }

  @override
  Decoration buildDecoration() => BoxDecoration(
      color: ColorManagement.mainBlue.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: ColorManagement.mainBlue));

  Widget _buildHeaderRow() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 8.sp),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Light grey background for header
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'اسم الطالب',
              textAlign: TextAlign.right, // Align text to the right for Arabic
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'الاشتراك',
              textAlign: TextAlign.center,
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'دُفع',
              textAlign: TextAlign.center,
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'باقي',
              textAlign: TextAlign.center,
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentReportCard(StudentReport student) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6.sp, horizontal: 0.sp),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                student.name,
                textAlign: TextAlign
                    .center, // Align text to the right for Arabic names
                style: TextManagement.alexandria12RegularBlack,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${student.subscription}',
                textAlign: TextAlign.center,
                style: TextManagement.alexandria12RegularBlack,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${student.totalPaid}',
                textAlign: TextAlign.center,
                style: TextManagement
                    .alexandria12RegularBlack, // Paid amounts in green
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${student.remaining}',
                textAlign: TextAlign.center,
                style: TextManagement
                    .alexandria12RegularBlack, // Remaining amounts in red
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PDFExportButton extends StatelessWidget {
  final String teacherName;
  final List<StudentReport> students;

  const PDFExportButton({
    super.key,
    required this.teacherName,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    if (students.isEmpty) {
      return const SizedBox.shrink();
    }

    return ContainerShadow(
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: GestureDetector(
          onTap: () {
            PDFGeneratorHelper.generateStudentsByTeacherPDF(
              context,
              teacherName,
              students,
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
