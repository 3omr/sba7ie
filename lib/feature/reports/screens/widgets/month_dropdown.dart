import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';

class MonthDropdown extends StatelessWidget {
  final List<Map<int, String>> months;
  final ValueChanged<int?> onChanged;

  const MonthDropdown({
    super.key,
    required this.months,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ContainerShadow(
      child: Padding(
        padding: EdgeInsets.all(0.02.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'قم باختيار الشهر',
              style: TextManagement.alexandria18BoldMainBlue,
            ),
            SizedBox(height: 0.02.sh),
            DropdownButtonFormField<int>(
              hint: Text(
                'اختر الشهر',
                style: TextManagement.alexandria16RegularBlack,
              ),
              isExpanded: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: ColorManagement.lightBlue,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
              items: months.map((month) {
                return DropdownMenuItem<int>(
                  value: month.keys.first,
                  child: Text(
                    month.values.first,
                    style: TextManagement.alexandria16RegularBlack,
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
