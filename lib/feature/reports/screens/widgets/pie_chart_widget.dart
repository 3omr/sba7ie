import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';

class SummaryPieChart extends StatelessWidget {
  final double totalMoneyFromSubscriptions;
  final double remain;

  const SummaryPieChart({
    super.key,
    required this.totalMoneyFromSubscriptions,
    required this.remain,
  });

  @override
  Widget build(BuildContext context) {
    final double total = totalMoneyFromSubscriptions + remain;
    final Object paidPercentage = total > 0
        ? (totalMoneyFromSubscriptions / total * 100).toStringAsFixed(1)
        : 0.0;
    final Object remainPercentage =
        total > 0 ? (remain / total * 100).toStringAsFixed(1) : 0.0;

    return ContainerShadow(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 0.05.sw,
          vertical: 0.02.sh,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ملخص المالية',
              style: TextManagement.alexandria18BoldMainBlue,
              semanticsLabel: 'ملخص المالية',
            ),
            SizedBox(height: 0.02.sh),
            // Numerical Values Section
            Container(
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: ColorManagement.lightBlue,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildValueRow(
                    label: 'الإجمالي',
                    value: total.toStringAsFixed(0),
                    color: ColorManagement.darkGrey,
                  ),
                  SizedBox(height: 8.h),
                  _buildValueRow(
                    label: 'المدفوع',
                    value: totalMoneyFromSubscriptions.toStringAsFixed(0),
                    color: ColorManagement.mainBlue,
                  ),
                  SizedBox(height: 8.h),
                  _buildValueRow(
                    label: 'المتبقي',
                    value: remain.toStringAsFixed(0),
                    color: ColorManagement.accentOrange,
                  ),
                ],
              ),
            ),
            SizedBox(height: 0.02.sh),
            SizedBox(
              height: 0.25.sh, // Reduced height to make the chart smaller
              width: double.infinity,
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: totalMoneyFromSubscriptions,
                      title: 'الإيرادات\n$paidPercentage%',
                      color: ColorManagement.mainBlue,
                      titleStyle:
                          TextManagement.alexandria14RegularDarkGrey.copyWith(
                        color: ColorManagement.white,
                        fontWeight: FontWeight.w600,
                      ),
                      radius: 70.r,
                      titlePositionPercentageOffset: 0.5,
                    ),
                    PieChartSectionData(
                      value: remain,
                      title: 'المتبقي\n$remainPercentage%',
                      color: ColorManagement.accentOrange,
                      titleStyle:
                          TextManagement.alexandria14RegularDarkGrey.copyWith(
                        color: ColorManagement.white,
                        fontWeight: FontWeight.w600,
                      ),
                      radius: 70.r,
                      titlePositionPercentageOffset: 0.5,
                    ),
                  ],
                  centerSpaceRadius: 40.r,
                  sectionsSpace: 4.r,
                  borderData: FlBorderData(show: false),
                ),
                swapAnimationDuration: const Duration(milliseconds: 300),
                swapAnimationCurve: Curves.easeInOut,
              ),
            ),
            SizedBox(height: 16.h),
            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(
                  color: ColorManagement.mainBlue,
                  text: 'الإيرادات',
                ),
                SizedBox(width: 24.w),
                _buildLegendItem(
                  color: ColorManagement.accentOrange,
                  text: 'المتبقي',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValueRow({
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextManagement.alexandria16RegularBlack.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          '$value جنيه',
          style: TextManagement.alexandria16RegularBlack.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem({required Color color, required String text}) {
    return Row(
      children: [
        Container(
          width: 16.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          text,
          style: TextManagement.alexandria16RegularBlack,
        ),
      ],
    );
  }
}
