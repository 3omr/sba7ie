import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/feature/students/data/models/student_model.dart';

class StudentProfileSection extends StatelessWidget {
  const StudentProfileSection({
    super.key,
    required this.student,
    required this.teacherName,
  });

  final Student student;
  final String teacherName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.04.sw),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorManagement.mainBlue.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 0.12.sw,
            backgroundColor: ColorManagement.mainBlue.withOpacity(0.15),
            child: FaIcon(
              FontAwesomeIcons.user,
              size: 0.14.sw,
              color: ColorManagement.mainBlue,
            ),
          ),
          SizedBox(width: 0.06.sw),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.name ?? '',
                  style: TextManagement.alexandria20RegularBlack.copyWith(
                    color: ColorManagement.mainBlue,
                    fontWeight: FontWeight.w800,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 0.01.sh),
                Text("اسم المعلمة : $teacherName",
                    style: TextManagement.alexandria14RegularDarkGrey),
                SizedBox(height: 0.01.sh),
                Text("رقم الجوال : ${student.phoneNumber ?? ''}",
                    style: TextManagement.alexandria14RegularDarkGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
