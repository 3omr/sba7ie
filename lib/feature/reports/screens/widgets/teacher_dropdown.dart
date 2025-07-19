import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';

class TeacherDropdown extends StatelessWidget {
  final List<Teacher> teachers;
  final int? selectedTeacherId;
  final ValueChanged<int?> onChanged;

  const TeacherDropdown({
    super.key,
    required this.teachers,
    required this.selectedTeacherId,
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
              'قم باختيار المعلم',
              style: TextManagement.alexandria18BoldMainBlue,
            ),
            SizedBox(height: 0.02.sh),
            DropdownButtonFormField<int>(
              hint: Text(
                'اختر المعلم',
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
              value: selectedTeacherId,
              items: teachers.map((teacher) {
                return DropdownMenuItem<int>(
                  value: teacher.id,
                  child: Text(
                    teacher.name ?? "",
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
