import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/helper/date_helper.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/app_snack_bars.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/feature/students/data/models/subscription_model.dart';
import 'package:tasneem_sba7ie/feature/students/logic/student_subscription_cubit/student_subscription_cubit.dart';

class StudentDialogs {
  static void showAddAbsenceDiscountDialog(
      {required BuildContext context,
      required StudentSubscriptionCubit studentSubscriptionCubit}) {
          showDialog(
            context: context,
            builder: (context) {
              final TextEditingController amountController =
                  TextEditingController();
              DateTime currentDate = DateTime.now();

              return AlertDialog(
                title: Text(
                  'إضافة دفعة جديدة',
                  style: TextManagement.alexandria18RegularBlack,
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      ContainerShadow(
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: "المبلغ"),
                        ),
                      ),
                      SizedBox(height: 0.02.sh),
                      SizedBox(
                        width: 300.w,
                        height: 400.h,
                        child: DaysPicker(
                          selectedCellTextStyle:
                              TextManagement.alexandria16RegularWhite,
                          minDate: DateTime(2025, 7, 1),
                          maxDate: DateTime(2026, 12, 31),
                          initialDate: currentDate,
                          onDateSelected: (value) {
                            currentDate = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text('إلغاء',
                        style: TextManagement.alexandria16RegularBlack),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      amountController.text = amountController.text.trim();
                      if (amountController.text.isEmpty) {
                        AppSnackBars.showErrorSnackBar(
                            context: context, errorMsg: 'يرجى إدخال المبلغ');
                        return;
                      }
                      await studentSubscriptionCubit
                          .setStudentSubscription(Subscription(
                        idStudent: studentSubscriptionCubit.student.id,
                        money: int.tryParse(amountController.text) ?? 0,
                        date: DateHelper.getFormattedCurrentDateDay(
                            currentDate.toString()),
                      ));
                      AppSnackBars.showSuccessSnackBar(
                          context: context,
                          successMsg: 'تمت إضافة الدفعة بنجاح');
                      Navigator.of(context).pop();
                    },
                    child: Text('إضافة',
                        style: TextManagement.alexandria16RegularWhite),
                  ),
                ],
              );
            },
          );
       
      }
}
