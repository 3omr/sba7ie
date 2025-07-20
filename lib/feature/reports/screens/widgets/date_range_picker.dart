import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_report_by_date_range_cubit/student_report_by_date_range_cubit.dart';

class DateRangePicker extends StatelessWidget {
  final StudentReportByDateRangeCubit cubit;

  const DateRangePicker({
    super.key,
    required this.cubit,
  });

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('اختر التاريخ',
                  style: TextManagement.alexandria18RegularBlack),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    SizedBox(
                      width: 0.8.sw,
                      height: 0.4.sh,
                      child: DaysPicker(
                        selectedCellTextStyle:
                            TextManagement.alexandria16RegularWhite,
                        minDate: DateTime(2025, 7, 1),
                        maxDate: DateTime(2026, 12, 31),
                        initialDate: DateTime.now(),
                        onDateSelected: (value) {
                          if (isStart) {
                            cubit.startDate = value;
                          } else {
                            cubit.endDate = value;
                          }
                          context.pop();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return ContainerShadow(
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'قم باختيار التاريخ',
              style: TextManagement.alexandria18BoldMainBlue,
            ),
            SizedBox(height: 0.02.sh),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, true),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: ColorManagement.lightBlue,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        cubit.startDate != null
                            ? DateFormat('dd/MM/yyyy').format(cubit.startDate!)
                            : 'تاريخ البداية',
                        textAlign: TextAlign.center,
                        style: TextManagement.alexandria14RegularBlack,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context, false),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: ColorManagement.lightBlue,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        cubit.endDate != null
                            ? DateFormat('dd/MM/yyyy').format(cubit.endDate!)
                            : 'تاريخ النهاية',
                        textAlign: TextAlign.center,
                        style: TextManagement.alexandria14RegularBlack,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: cubit.startDate != null && cubit.endDate != null
                      ? () => cubit.getStudentPaymentsByDateRange(
                          cubit.startDate!, cubit.endDate!)
                      : null,
                  child: Container(
                    padding: EdgeInsets.all(12.sp),
                    decoration: BoxDecoration(
                      color: cubit.startDate != null && cubit.endDate != null
                          ? ColorManagement.mainBlue
                          : ColorManagement.darkGrey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.search,
                      color: ColorManagement.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
