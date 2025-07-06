import 'package:flutter/material.dart';
import 'package:tasneem_sba7ie/utl/color_management.dart';
import 'package:tasneem_sba7ie/utl/text_management.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BoxContainImageAndTexts extends StatelessWidget {
  const BoxContainImageAndTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.02.sh, left: 0.045.sw, right: 0.045.sw),
      width: 1.sw,
      height: 0.2.sh,
      decoration: BoxDecoration(
          color: ColorManagement.yellow,
          borderRadius: BorderRadius.all(Radius.circular(0.02.sw))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("برنامج إدارة الحضانة",
                  style: TextManagement.cairoS06WBoldWhite.copyWith(
                    color: ColorManagement.deepBlue,
                  )),
              Text(
                "تحصيل اشتراكات الصباحي",
                style: TextManagement.cairoS05W500White
                    .copyWith(fontSize: 0.04.sw),
              )
            ],
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 0.01.sw, vertical: 0.01.sh),
            child: Image.asset("assets/png/childrens.png"),
          )
        ],
      ),
    );
  }
}
