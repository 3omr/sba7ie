import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';

class TeacherInfoCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final LinearGradient gradient;

  const TeacherInfoCard({
    super.key,
    required this.icon,
    required this.color,
    required this.text,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.02.sh),
      decoration: BoxDecoration(
        gradient: gradient,
        border: Border.all(color: color.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            radius: 0.07.sw,
            child: FaIcon(
              icon,
              color: color,
              size: 0.08.sw,
            ),
          ),
          SizedBox(width: 0.05.sw),
          Expanded(
            child: Text(
              text,
              style: TextManagement.alexandria16RegularBlack.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorManagement.black.withOpacity(0.9),
              ),
              semanticsLabel: text,
            ),
          ),
        ],
      ),
    );
  }
}
