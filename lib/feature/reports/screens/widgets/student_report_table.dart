import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/student_report.dart';

class StudentReportTable extends StatelessWidget {
  final List<StudentReport> studentReports;
  const StudentReportTable({super.key, required this.studentReports});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.4.sh,
      child: ContainerShadow(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            children: [
              _buildHeaderRow(),
              SizedBox(height: 8.sp), 
              Expanded(
                child: ListView.builder(
                  itemCount: studentReports.length,
                  itemBuilder: (context, index) {
                    final student = studentReports[index];
                    return _buildStudentReportCard(student);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
