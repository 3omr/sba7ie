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
                ColorManagement.lightGrey.withOpacity(0.3),
                ColorManagement.white,
                ColorManagement.white.withOpacity(0.95),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.6, 1.0],
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
                  borderRadius: BorderRadius.circular(25.r),
                  gradient: LinearGradient(
                    colors: [
                      ColorManagement.darkGrey.withOpacity(0.9),
                      ColorManagement.mainBlue,
                      ColorManagement.mainBlue.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0.0, 0.6, 1.0],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManagement.mainBlue.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 0,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: ColorManagement.darkGrey.withOpacity(0.1),
                      blurRadius: 40,
                      spreadRadius: 0,
                      offset: const Offset(0, 20),
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
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorManagement.yellow.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: ColorManagement.yellow.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            "مرحبا بك في",
                            style: TextManagement.alexandria16RegularLightGrey
                                .copyWith(
                              color: ColorManagement.yellow.withOpacity(0.9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 0.01.sh),
                        Text(
                          "حضانة تسنيم الخاصة",
                          style: TextManagement.alexandria22BoldWhite,
                        ),
                        SizedBox(height: 0.01.sh),
                        Text(
                          "إدارة متطورة لمستقبل أفضل",
                          style: TextManagement.alexandria16RegularLightGrey
                              .copyWith(
                            color: ColorManagement.lightGrey.withOpacity(0.8),
                            fontSize: 14.sp,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: ColorManagement.yellow.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorManagement.yellow.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.children,
                        size: 0.06.sh,
                        color: ColorManagement.yellow,
                      ),
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
                child: Row(
                  children: [
                    Container(
                      width: 4.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        color: ColorManagement.mainBlue,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      "الأقسام الرئيسية",
                      style: TextManagement.alexandria24BoldBlack.copyWith(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
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
                    onTap: () {
                      context.pushNamed(Routers.students);
                    },
                  ),
                  HomeScreenSection(
                    icon: FontAwesomeIcons.gear,
                    text: "الاعدادات",
                    onTap: () {
                      context.pushNamed(Routers.settings);
                    },
                  ),
                  HomeScreenSection(
                    icon: FontAwesomeIcons.book,
                    text: "التقارير",
                    onTap: () {
                      context.pushNamed(Routers.reports);
                    },
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
