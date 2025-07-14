import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';

class HorizontalMonthCircles extends StatefulWidget {
  const HorizontalMonthCircles({super.key});

  @override
  State<HorizontalMonthCircles> createState() => _HorizontalMonthCirclesState();
}

class _HorizontalMonthCirclesState extends State<HorizontalMonthCircles> {
  late int _selectedMonthIndex;

  @override
  void initState() {
    super.initState();
    final DateTime now = DateTime.now();
    _selectedMonthIndex = now.month - 1; // Current month as selected
  }

  @override
  Widget build(BuildContext context) {
    final DateTime startDate = DateTime(2025, 1); // Start from July 2025
    const int numberOfMonths = 24;

    return SizedBox(
      height: 0.16.sh,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: ScrollController(
            initialScrollOffset: _selectedMonthIndex * 0.22.sw),
        itemCount: numberOfMonths,
        itemBuilder: (context, index) {
          final DateTime currentMonthDate =
              DateTime(startDate.year, startDate.month + index);
          final String monthName =
              DateFormat('شهر M', 'ar').format(currentMonthDate);
          final String year = DateFormat.y('ar').format(currentMonthDate);
          final bool isSelected = index == _selectedMonthIndex;

          return Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 0.025.sw, vertical: 0.015.sh),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedMonthIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: 0.22.sw,
                height: 0.22.sw,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            ColorManagement.mainBlue,
                            ColorManagement.mainBlue.withOpacity(0.7),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.grey.shade100,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected
                          ? ColorManagement.mainBlue.withOpacity(0.3)
                          : Colors.grey.withOpacity(0.2),
                      blurRadius: isSelected ? 12 : 8,
                      spreadRadius: isSelected ? 3 : 1,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        monthName,
                        style: TextManagement.alexandria18RegularBlack.copyWith(
                          color:
                              isSelected ? Colors.white : ColorManagement.black,
                          fontSize: 20.sp,
                          fontWeight:
                              isSelected ? FontWeight.w800 : FontWeight.w500,
                        ),
                        semanticsLabel: 'الشهر: $monthName',
                      ),
                      Text(
                        year,
                        style:
                            TextManagement.alexandria16RegularDarkGrey.copyWith(
                          color: isSelected
                              ? Colors.white.withOpacity(0.9)
                              : ColorManagement.darkGrey,
                          fontSize: 16.sp,
                        ),
                        semanticsLabel: 'السنة: $year',
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
