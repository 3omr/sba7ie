import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';

class HorizontalMonthCircles extends StatelessWidget {
  const HorizontalMonthCircles({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime startDate = DateTime(2025, 7);
    const int numberOfMonths = 12;

    return SizedBox(
      height: 0.15.sh,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: numberOfMonths,
        itemBuilder: (context, index) {
          final DateTime currentMonthDate =
              DateTime(startDate.year, startDate.month + index);

          final String monthName =
              DateFormat('شهر M', 'ar').format(currentMonthDate);
          final String year = DateFormat.y('ar').format(currentMonthDate);

          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 0.02.sw,
              vertical: 0.02.sh,
            ),
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 0.2.sw,
                height: 0.2.sw,
                decoration: BoxDecoration(
                  color: ColorManagement.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ColorManagement.mainBlue.withOpacity(0.15),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        monthName,
                        style: TextManagement.alexandria18RegularBlack,
                      ),
                      Text(
                        year,
                        style: TextManagement.alexandria16RegularDarkGrey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
