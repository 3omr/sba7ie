import 'package:flutter/material.dart';
import 'package:tasneem_sba7ie/utl/color_management.dart';
import 'package:tasneem_sba7ie/utl/text_management.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesList extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  const CategoriesList(
      {super.key, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 0.45.sw,
        height: 0.09.sh,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.02.sw),
          border: Border.all(
            color: ColorManagement.grey,
            width: 0.004.sw,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 0.12.sw,
              height: 0.06.sh,
              margin: EdgeInsets.symmetric(horizontal: 0.012.sw),
              decoration: BoxDecoration(
                color: ColorManagement.deepPurple,
                borderRadius: BorderRadius.circular(0.02.sw),
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 0.09.sw,
                ),
              ),
            ),
            Text(
              text,
              style: TextManagement.cairoS05W500White
                  .copyWith(color: Colors.black, fontSize: 0.045.sw),
            )
          ],
        ),
      ),
    );
  }
}
