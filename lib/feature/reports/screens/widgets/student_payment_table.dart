import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/feature/reports/data/models/student_payment.dart';

class StudentPaymentTable extends StatelessWidget {
  final List<StudentPayment> studentPayments;

  const StudentPaymentTable({
    Key? key,
    required this.studentPayments,
  }) : super(key: key);

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
                  itemCount: studentPayments.length,
                  itemBuilder: (context, index) {
                    final payment = studentPayments[index];
                    return _buildStudentPaymentCard(payment);
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
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'اسم الطالب',
              textAlign: TextAlign.right,
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "المعلمة",
              textAlign: TextAlign.center,
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              'المبلغ',
              textAlign: TextAlign.center,
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'التاريخ',
              textAlign: TextAlign.center,
              style: TextManagement.alexandria14RegularBlack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentPaymentCard(StudentPayment payment) {
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
                payment.studentName,
                textAlign: TextAlign.center,
                style: TextManagement.alexandria12RegularBlack,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                payment.teacherName,
                textAlign: TextAlign.center,
                style: TextManagement.alexandria12RegularBlack,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                '${payment.moneyPaid}',
                textAlign: TextAlign.center,
                style: TextManagement.alexandria12RegularBlack.copyWith(
                  color: Colors.green[700], // لون أخضر للمبلغ المدفوع
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                DateFormat('dd/MM/yyyy').format(payment.date),
                textAlign: TextAlign.center,
                style: TextManagement.alexandria12RegularBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
