import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/teacher_reports_cubit/teacher_reports_cubit.dart';

class TeacherChooseMonth extends StatelessWidget {
  const TeacherChooseMonth({
    super.key,
    required this.cubit,
  });

  final TeacherReportsCubit cubit;

  Future<void> _selectDate(
      BuildContext context, TeacherReportsCubit cubit) async {
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
                      child: MonthPicker(
                        selectedCellTextStyle:
                            TextManagement.alexandria16RegularWhite,
                        minDate: DateTime(2025, 7),
                        maxDate: DateTime(2026, 12),
                        initialDate: DateTime.now(),
                        onDateSelected: (value) {
                          cubit.currentDate = value;
                          cubit.getTeacherSalaryReportForMonth(
                              DateFormat('MM-yyyy', 'en')
                                  .format(cubit.currentDate!));
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("قم باختيار الشهر",
            style: TextManagement.alexandria18BoldMainBlue),
        SizedBox(height: 0.02.sh),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _selectDate(context, cubit);
              },
              child: Container(
                alignment: Alignment.center,
                width: 0.5.sw,
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: ColorManagement.lightBlue,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  cubit.currentDate != null
                      ? DateFormat('MM-yyyy', 'en').format(cubit.currentDate)
                      : "اختر الشهر",
                  textAlign: TextAlign.center,
                  style: TextManagement.alexandria14RegularBlack,
                ),
              ),
            ),
            SizedBox(width: 0.05.sw),
            GestureDetector(
              onTap: () {
                cubit.currentDate != null
                    ? cubit.getTeacherSalaryReportForMonth(
                        DateFormat('MM-yyyy', 'en').format(cubit.currentDate!),
                      )
                    : null;
              },
              child: Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  color: cubit.currentDate != null
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
            )
          ],
        ),
        SizedBox(height: 0.02.sh),
      ],
    );
  }
}
