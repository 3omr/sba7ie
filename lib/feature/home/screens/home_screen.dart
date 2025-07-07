import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tasneem_sba7ie/core/router/router.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/feature/home/screens/widgets/home_screen_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 1.sh,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorManagement.lightGrey.withOpacity(0.9),
                ColorManagement.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 0.25.sh,
                padding: EdgeInsets.only(
                    left: 0.04.sw, right: 0.04.sw, top: 0.06.sh),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorManagement.mainBlue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                  gradient: const LinearGradient(
                    colors: [
                      ColorManagement.darkGrey,
                      ColorManagement.mainBlue,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManagement.darkGrey.withOpacity(0.4),
                      blurRadius: 12,
                      spreadRadius: 3,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "مرحبا بك في",
                          style: TextManagement.alexandria16RegularLightGrey,
                        ),
                        SizedBox(height: 0.01.sh),
                        Text(
                          "حضانة تسنيم الخاصة",
                          style: TextManagement.ruwudu30BoldWhite,
                        ),
                      ],
                    ),
                    const Spacer(),
                    FaIcon(
                      FontAwesomeIcons.children,
                      size: 0.08.sh,
                      color: ColorManagement.yellow,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0.03.sh),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0.045.sw),
                width: double.infinity,
                height: 0.22.sh,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorManagement.yellow,
                      ColorManagement.yellow.withOpacity(0.85),
                      ColorManagement.accentOrange,
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManagement.accentOrange.withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "برنامج إدارة الحضانة",
                          style: TextManagement.lalezar24BoldOrange,
                        ),
                        SizedBox(height: 0.01.sh),
                        Text(
                          "تحصيل اشتراكات الصباحي",
                          style: TextManagement.alexandria18RegularBlack,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.02.sw, vertical: 0.015.sh),
                      child: Image.asset(
                        "assets/png/childrens.png",
                        height: 0.12.sh,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0.05.sh),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.06.sw),
                child: Text(
                  "الأقسام",
                  style: TextManagement.alexandria24BoldBlack,
                ),
              ),
              SizedBox(height: 0.02.sh),
              GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0.03.sh,
                  crossAxisSpacing: 0.03.sw,
                  childAspectRatio: 1.4,
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 0.06.sw, vertical: 0.03.sh),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  HomeScreenSection(
                    icon: FontAwesomeIcons.personChalkboard,
                    text: "المعلمون",
                    onTap: () {
                      context.pushNamed(Routers.teachers);
                    },
                  ),
                  HomeScreenSection(
                    icon: FontAwesomeIcons.child,
                    text: "الطلاب",
                    onTap: () {}, // Add navigation logic here
                  ),
                  HomeScreenSection(
                    icon: FontAwesomeIcons.moneyBill,
                    text: "الاشتراكات",
                    onTap: () {}, // Add navigation logic here
                  ),
                  HomeScreenSection(
                    icon: FontAwesomeIcons.book,
                    text: "التقارير",
                    onTap: () {}, // Add navigation logic here
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

