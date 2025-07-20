import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/student_reports_cubit/student_reports_cubit.dart';

class DateRangePicker extends StatefulWidget {
  final StudentReportsCubit? cubit;

  const DateRangePicker({
    super.key,
    this.cubit,
  });

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  DateTime? startDate;
  DateTime? endDate;

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
                          setState(() {
                            if (isStart) {
                              startDate = value;
                            } else {
                              endDate = value;
                            }
                          });
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
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => _selectDate(context, true),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: ColorManagement.lightBlue,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    startDate != null
                        ? DateFormat('dd/MM/yyyy').format(startDate!)
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
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: ColorManagement.lightBlue,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    endDate != null
                        ? DateFormat('dd/MM/yyyy').format(endDate!)
                        : 'تاريخ النهاية',
                    textAlign: TextAlign.center,
                    style: TextManagement.alexandria14RegularBlack,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: startDate != null && endDate != null
                  ? () => widget.cubit!
                      .getStudentPaymentsByDateRange(startDate!, endDate!)
                  : null,
              child: Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  color: startDate != null && endDate != null
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
      ),
    );
  }
}

