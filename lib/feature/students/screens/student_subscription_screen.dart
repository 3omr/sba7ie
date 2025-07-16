import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/feature/students/data/models/student_model.dart';

class StudentSubscriptionScreen extends StatelessWidget {
  final Student student;
  final int subscription;
  final int paid;
  final int remaining;
  final List<Map<String, dynamic>> payments; // [{money, date, id}]
  final VoidCallback? onAddPayment;
  final VoidCallback? onSendMsg;
  final Function(int id)? onDeletePayment;

  const StudentSubscriptionScreen({
    super.key,
    required this.student,
    required this.subscription,
    required this.paid,
    required this.remaining,
    required this.payments,
    this.onAddPayment,
    this.onSendMsg,
    this.onDeletePayment,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          student.name ?? '',
          style: TextManagement.alexandria20RegularBlack.copyWith(
            color: ColorManagement.mainBlue,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.03.sh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Profile Section ---
              Container(
                padding: EdgeInsets.all(0.04.sw),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManagement.mainBlue.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 0.12.sw,
                      backgroundColor:
                          ColorManagement.mainBlue.withOpacity(0.15),
                      child: FaIcon(
                        FontAwesomeIcons.userGraduate,
                        size: 0.14.sw,
                        color: ColorManagement.mainBlue,
                      ),
                    ),
                    SizedBox(width: 0.06.sw),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            student.name ?? '',
                            style: TextManagement.alexandria20RegularBlack
                                .copyWith(
                              color: ColorManagement.mainBlue,
                              fontWeight: FontWeight.w800,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 0.01.sh),
                          Text(
                            "رقم الهاتف: ${student.phoneNumber ?? ''}",
                            style: TextManagement.alexandria16RegularDarkGrey
                                .copyWith(
                              color: ColorManagement.darkGrey.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0.04.sh),

              // --- Subscription Info Section ---
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.04.sw, vertical: 0.02.sh),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManagement.mainBlue.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoColumn('الاشتراك', subscription.toString()),
                    _buildInfoColumn('المدفوع', paid.toString()),
                    _buildInfoColumn('الباقي', remaining.toString()),
                    IconButton(
                      onPressed: onSendMsg,
                      icon: const Icon(Icons.textsms_outlined),
                      color: ColorManagement.mainBlue,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0.04.sh),

              // --- Payments Title ---
              Text(
                "المدفوعات",
                style: TextManagement.alexandria18RegularBlack.copyWith(
                  color: ColorManagement.mainBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 0.02.sh),

              // --- Add Payment Section ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 0.4.sw,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'القسط',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onAddPayment,
                    icon: Icon(
                      Icons.add_box_outlined,
                      color: ColorManagement.mainBlue,
                      size: 0.09.sw,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.03.sh),

              // --- Payments List Header ---
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                      color: ColorManagement.mainBlue.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    _buildHeaderCell('م', 0.15),
                    _buildHeaderCell('المبلغ', 0.25),
                    _buildHeaderCell('التاريخ', 0.32),
                    _buildHeaderCell('حذف', 0.25),
                  ],
                ),
              ),
              SizedBox(height: 0.01.sh),

              // --- Payments List ---
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  final payment = payments[index];
                  return ContainerShadow(
                    child: Row(
                      children: [
                        _buildCell((index + 1).toString(), 0.15),
                        _buildCell(payment['money'].toString(), 0.25),
                        _buildCell(payment['date'].toString(), 0.32),
                        SizedBox(
                          width: 0.25.sw,
                          child: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () =>
                                onDeletePayment?.call(payment['id']),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextManagement.alexandria16BoldMainBlue),
        SizedBox(height: 4),
        Text(value, style: TextManagement.alexandria16RegularBlack),
      ],
    );
  }

  Widget _buildHeaderCell(String text, double widthFactor) {
    return SizedBox(
      width: widthFactor.sw,
      child: Center(
        child: Text(
          text,
          style: TextManagement.alexandria16BoldMainBlue,
        ),
      ),
    );
  }

  Widget _buildCell(String text, double widthFactor) {
    return SizedBox(
      width: widthFactor.sw,
      child: Center(
        child: Text(
          text,
          style: TextManagement.alexandria16RegularBlack,
        ),
      ),
    );
  }
}
