import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/teacher_salary_report_model.dart';

class TeacherSalaryReportTable extends StatelessWidget {
  final DateTime? monthYear;
  final List<TeacherSalaryReportModel> teacherReports;
  const TeacherSalaryReportTable(
      {super.key, required this.teacherReports, this.monthYear});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.4.sh,
      child: ContainerShadow(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                monthYear == null
                    ? 'تقرير الراتب للمدرسين'
                    : 'تقرير الراتب للمدرسين في شهر ${DateFormat('MMMM', 'ar').format(monthYear!)}',
                style: TextManagement.alexandria16BoldMainBlue,
              ),
              SizedBox(height: 0.02.sh),
              _buildHeaderRow(),
              SizedBox(height: 8.sp),
              Expanded(
                child: ListView.builder(
                  itemCount: teacherReports.length,
                  itemBuilder: (context, index) {
                    final teacher = teacherReports[index];
                    return _buildTeacherSalaryCard(teacher);
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
              'اسم المدرس',
              textAlign: TextAlign.right, // Align text to the right for Arabic
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'الراتب',
              textAlign: TextAlign.center,
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'غياب',
              textAlign: TextAlign.center,
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'خصم',
              textAlign: TextAlign.center,
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'صافي الراتب',
              textAlign: TextAlign.center,
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherSalaryCard(TeacherSalaryReportModel teacher) {
    // Determine colors based on values
    Color netSalaryColor = teacher.netSalary < teacher.salary
        ? Colors.red[600]!
        : Colors.green[600]!;

    Color absenceColor =
        teacher.daysAbsent > 0 ? Colors.orange[600]! : Colors.grey[700]!;

    Color discountColor =
        teacher.discounts > 0 ? Colors.red[600]! : Colors.grey[700]!;

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
                teacher.teacherName,
                textAlign: TextAlign.center,
                style: TextManagement.alexandria12RegularBlack,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${teacher.salary}',
                textAlign: TextAlign.center,
                style: TextManagement.alexandria12RegularBlack,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${teacher.daysAbsent}',
                textAlign: TextAlign.center,
                style: TextManagement.alexandria12RegularBlack.copyWith(
                  color: absenceColor,
                  fontWeight: teacher.daysAbsent > 0
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${teacher.discounts}',
                textAlign: TextAlign.center,
                style: TextManagement.alexandria12RegularBlack.copyWith(
                  color: discountColor,
                  fontWeight: teacher.discounts > 0
                      ? FontWeight.bold
                      : FontWeight.normal,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${teacher.netSalary}',
                textAlign: TextAlign.center,
                style: TextManagement.alexandria12RegularBlack.copyWith(
                  color: netSalaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Optional: Enhanced version with more features
class EnhancedTeacherSalaryReportTable extends StatelessWidget {
  final List<TeacherSalaryReportModel> teacherReports;
  final String monthYear;
  final VoidCallback? onTeacherTap;

  const EnhancedTeacherSalaryReportTable({
    super.key,
    required this.teacherReports,
    required this.monthYear,
    this.onTeacherTap,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate totals
    int totalBaseSalary =
        teacherReports.fold(0, (sum, teacher) => sum + teacher.salary);
    int totalNetSalary =
        teacherReports.fold(0, (sum, teacher) => sum + teacher.netSalary);
    int totalDeductions =
        teacherReports.fold(0, (sum, teacher) => sum + teacher.discounts);
    int totalAbsentDays =
        teacherReports.fold(0, (sum, teacher) => sum + teacher.daysAbsent);

    return SizedBox(
      height: 0.5.sh, // Increased height for summary
      child: ContainerShadow(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            children: [
              // Month title
              Text(
                'تقرير رواتب المدرسين - $monthYear',
                style: TextManagement.alexandria16RegularBlack,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.sp),

              _buildHeaderRow(),
              SizedBox(height: 8.sp),

              Expanded(
                child: ListView.builder(
                  itemCount: teacherReports.length,
                  itemBuilder: (context, index) {
                    final teacher = teacherReports[index];
                    return _buildTeacherSalaryCard(teacher, context);
                  },
                ),
              ),

              // Summary section
              _buildSummarySection(totalBaseSalary, totalNetSalary,
                  totalDeductions, totalAbsentDays),
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
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'اسم المدرس',
              textAlign: TextAlign.right,
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'الراتب',
              textAlign: TextAlign.center,
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'غياب',
              textAlign: TextAlign.center,
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'خصومات',
              textAlign: TextAlign.center,
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'صافي الراتب',
              textAlign: TextAlign.center,
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherSalaryCard(
      TeacherSalaryReportModel teacher, BuildContext context) {
    Color netSalaryColor = teacher.netSalary < teacher.salary
        ? Colors.red[600]!
        : Colors.green[600]!;

    Color absenceColor =
        teacher.daysAbsent > 0 ? Colors.orange[600]! : Colors.grey[700]!;

    Color discountColor =
        teacher.discounts > 0 ? Colors.red[600]! : Colors.grey[700]!;

    return InkWell(
      onTap: onTeacherTap,
      child: Card(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      teacher.teacherName,
                      textAlign: TextAlign.center,
                      style: TextManagement.alexandria12RegularBlack,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (teacher.hasDeductions)
                      Container(
                        margin: EdgeInsets.only(top: 2.sp),
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.sp, vertical: 1.sp),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(4.sp),
                        ),
                        child: Text(
                          'خصومات',
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: Colors.orange[700],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '${teacher.salary}',
                  textAlign: TextAlign.center,
                  style: TextManagement.alexandria12RegularBlack,
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '${teacher.daysAbsent}',
                  textAlign: TextAlign.center,
                  style: TextManagement.alexandria12RegularBlack.copyWith(
                    color: absenceColor,
                    fontWeight: teacher.daysAbsent > 0
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '${teacher.discounts}',
                  textAlign: TextAlign.center,
                  style: TextManagement.alexandria12RegularBlack.copyWith(
                    color: discountColor,
                    fontWeight: teacher.discounts > 0
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  '${teacher.netSalary}',
                  textAlign: TextAlign.center,
                  style: TextManagement.alexandria12RegularBlack.copyWith(
                    color: netSalaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummarySection(
      int totalBase, int totalNet, int totalDeductions, int totalAbsent) {
    return Container(
      margin: EdgeInsets.only(top: 8.sp),
      padding: EdgeInsets.all(12.sp),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8.sp),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem('إجمالي الرواتب', '$totalBase', Colors.blue[700]!),
          _buildSummaryItem('إجمالي صافي', '$totalNet', Colors.green[700]!),
          _buildSummaryItem(
              'إجمالي خصومات', '$totalDeductions', Colors.red[700]!),
          _buildSummaryItem('إجمالي غياب', '$totalAbsent', Colors.orange[700]!),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
