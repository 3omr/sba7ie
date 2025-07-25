import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/helper/app_settings.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/Error_state_widget.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/core/widgets/delete_dialog.dart';
import 'package:tasneem_sba7ie/core/widgets/empty_state_widget.dart';
import 'package:tasneem_sba7ie/core/widgets/horizontal_month_circles.dart';
import 'package:tasneem_sba7ie/feature/students/data/models/student_model.dart';
import 'package:tasneem_sba7ie/feature/students/logic/student_subscription_cubit/student_subscription_cubit.dart';
import 'package:tasneem_sba7ie/feature/students/screens/widgets/student_dialogs.dart';
import 'package:tasneem_sba7ie/feature/students/screens/widgets/student_profile_section.dart';
import 'package:tasneem_sba7ie/feature/students/screens/widgets/subscription_info_section.dart';

class StudentSubscriptionScreen extends StatefulWidget {
  final Student student;
  final String teacherName;

  const StudentSubscriptionScreen({
    super.key,
    required this.student,
    required this.teacherName,
  });

  @override
  State<StudentSubscriptionScreen> createState() =>
      _StudentSubscriptionScreenState();
}

class _StudentSubscriptionScreenState extends State<StudentSubscriptionScreen> {
  late final StudentSubscriptionCubit _studentSubscriptionCubit;

  @override
  void initState() {
    super.initState();

    _studentSubscriptionCubit = context.read<StudentSubscriptionCubit>();

    _studentSubscriptionCubit.student = widget.student;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'مدفوعات الطالب',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppSettings.APP_Working == StudentSubscriptionStatus.yearly
              ? StudentDialogs.showAddNewSubscriptionDialogYearly(
                  context: context,
                  studentSubscriptionCubit: _studentSubscriptionCubit,
                )
              : StudentDialogs.showAddNewSubscriptionDialogYearlyMonthly(
                  context: context,
                  studentSubscriptionCubit: _studentSubscriptionCubit);
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.03.sh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Profile Section ---
              StudentProfileSection(
                student: _studentSubscriptionCubit.student,
                teacherName: widget.teacherName,
              ),
              SizedBox(height: 0.04.sh),

              // selection month in subscriptions monthly
              if (AppSettings.APP_Working == StudentSubscriptionStatus.monthly)
                ContainerShadow(
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "قم باختيار الشهر",
                          style: TextManagement.alexandria18BoldMainBlue,
                        ),
                        HorizontalMonthCircles(
                            cubit: _studentSubscriptionCubit),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 0.02.sh),

              // --- Subscription Info Section ---
              SubscriptionInfoSection(
                  studentSubscriptionCubit: _studentSubscriptionCubit),
              SizedBox(height: 0.04.sh),
              if (AppSettings.APP_Working == StudentSubscriptionStatus.yearly)
                Column(
                  children: [
                    Text(
                      "المدفوعات",
                      style: TextManagement.alexandria18RegularBlack.copyWith(
                        color: ColorManagement.mainBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 0.02.sh),

                    // --- Payments List Header ---
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 0.01.sh),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                            color: ColorManagement.mainBlue.withOpacity(0.2)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildHeaderCell('م', 0.1),
                          _buildHeaderCell('المبلغ', 0.25),
                          _buildHeaderCell('التاريخ', 0.32),
                          _buildHeaderCell('حذف', 0.2),
                        ],
                      ),
                    ),
                    SizedBox(height: 0.01.sh),

                    // --- Payments List ---
                    BlocBuilder<StudentSubscriptionCubit,
                        StudentSubscriptionState>(
                      builder: (context, state) {
                        if (state is StudentSubscriptionLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is StudentSubscriptionError) {
                          return ErrorStateWidget(
                            text: state.error,
                            reloadFunction: () {
                              _studentSubscriptionCubit
                                  .getStudentSubscriptionsById();
                            },
                          );
                        }
                        if (state is StudentSubscriptionEmpty) {
                          return EmptyStateWidget(
                            text: 'لا توجد مدفوعات للطالب',
                            addButtonText: 'إضافة دفعة',
                            onPressed: () {
                              AppSettings.APP_Working ==
                                      StudentSubscriptionStatus.yearly
                                  ? StudentDialogs
                                      .showAddNewSubscriptionDialogYearly(
                                      context: context,
                                      studentSubscriptionCubit:
                                          _studentSubscriptionCubit,
                                    )
                                  : StudentDialogs
                                      .showAddNewSubscriptionDialogYearlyMonthly(
                                          context: context,
                                          studentSubscriptionCubit:
                                              _studentSubscriptionCubit);
                            },
                          );
                        }
                        return _paymentList();
                      },
                    ),
                  ],
                )

              // --- Payments Title ---
            ],
          ),
        ),
      ),
    );
  }

  ListView _paymentList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _studentSubscriptionCubit.subscriptions.length,
      itemBuilder: (context, index) {
        final payment = _studentSubscriptionCubit.subscriptions[index];
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 0.01.sh),
          child: ContainerShadow(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildCell((index + 1).toString(), 0.1),
                _buildCell(payment.money.toString(), 0.25),
                _buildCell(payment.date.toString(), 0.32),
                SizedBox(
                  width: 0.2.sw,
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DeleteDialog(
                            title: 'تأكيد الحذف',
                            msg: 'هل تريد حذف هذه الدفعة؟',
                            successMsg: 'تم حذف الدفعة بنجاح',
                            onDelete: () async {
                              await _studentSubscriptionCubit
                                  .deleteStudentSubscriptionByDate(
                                      payment.date ?? '');
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
