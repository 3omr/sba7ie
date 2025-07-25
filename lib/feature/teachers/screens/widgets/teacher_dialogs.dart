import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tasneem_sba7ie/core/helper/date_helper.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/app_snack_bars.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_management_cubit/teacher_management_cubit.dart';

class TeacherDialogs {
  static void showDeleteAbsencesDialog({
    required BuildContext context,
    required TeacherManagementCubit teacherManagementCubit,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'حذف الخصومات',
            style: TextManagement.alexandria18RegularBlack,
          ),
          content: Text(
            'هل تريد حذف الخصومات لشهر  ${DateHelper.getArabicMonthName(teacherManagementCubit.currentMonth)} فقط أم لكل الشهور؟',
            style: TextManagement.alexandria16RegularDarkGrey,
          ),
          actions: <Widget>[
            TextButton(
              child:
                  Text('إلغاء', style: TextManagement.alexandria16RegularBlack),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('حذف الشهر الحالي',
                  style: TextManagement.alexandria16RegularWhite
                      .copyWith(color: Colors.red)),
              onPressed: () async {
                await teacherManagementCubit.deleteTeacherAbsences(
                    isAllMonths: false);
                AppSnackBars.showSuccessSnackBar(
                  context: context,
                  successMsg: 'تم حذف الخصومات لهذا الشهر بنجاح',
                );
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('حذف كل الشهور',
                  style: TextManagement.alexandria16RegularWhite
                      .copyWith(color: Colors.red)),
              onPressed: () async {
                await teacherManagementCubit.deleteTeacherAbsences(
                    isAllMonths: true);
                AppSnackBars.showSuccessSnackBar(
                  context: context,
                  successMsg: 'تم حذف جميع الخصومات بنجاح',
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showAddAbsenceDiscountDialog({
    required BuildContext context,
    required TeacherManagementCubit teacherManagementCubit,
  }) {
    final TextEditingController absenceController = TextEditingController();
    final TextEditingController discountController = TextEditingController();
    DateTime currentDate = DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'إضافة غياب وخصومات أخرى',
            style: TextManagement.alexandria18RegularBlack,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ContainerShadow(
                  child: TextField(
                    controller: absenceController,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(hintText: "عدد أيام الغياب"),
                  ),
                ),
                SizedBox(height: 0.01.sh),
                ContainerShadow(
                  child: TextField(
                    controller: discountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "خصومات أخرى"),
                  ),
                ),
                SizedBox(height: 0.02.sh),
                SizedBox(
                  width: 300.w,
                  height: 400.h,
                  child: MonthPicker(
                    selectedCellTextStyle:
                        TextManagement.alexandria16RegularWhite,
                    minDate: DateTime(2025, 7),
                    maxDate: DateTime(2026, 12),
                    initialDate: currentDate,
                    onDateSelected: (value) {
                      currentDate = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:
                  Text('إلغاء', style: TextManagement.alexandria16RegularBlack),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child:
                  Text('إضافة', style: TextManagement.alexandria16RegularWhite),
              onPressed: () async {
                await teacherManagementCubit.setTeacherAbsenceAndDiscounts(
                  absentDays: int.tryParse(absenceController.text) ?? 0,
                  discounts: int.tryParse(discountController.text) ?? 0,
                  month: DateFormat('MM-yyyy').format(currentDate),
                );
                absenceController.clear();
                discountController.clear();
                AppSnackBars.showSuccessSnackBar(
                    context: context,
                    successMsg: 'تم إضافة الغياب والخصومات بنجاح');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
