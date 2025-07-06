import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback function;
  const HomeCard(
      {super.key,
      required this.icon,
      required this.text,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xff4776e6), Color(0xff8e54e9)],
              stops: [0, 1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade600,
                spreadRadius: 1,
                blurRadius: 15.r,
                offset: Offset(5.w, 5.h),
              ),
              BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5.w, -5.h),
                  blurRadius: 15.r,
                  spreadRadius: 1),
            ],
            borderRadius: BorderRadius.all(Radius.circular(16.r))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 60.w),
            SizedBox(height: 10.h),
            Text(
              text,
              style: GoogleFonts.cairo(color: Colors.white, fontSize: 20.sp),
            ),
          ],
        ),
      ),
    );
  }
}
