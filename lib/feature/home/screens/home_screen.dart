import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasneem_sba7ie/core/router/router.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/feature/home/screens/widgets/box_contain_image_and_texts.dart';
import 'package:tasneem_sba7ie/feature/home/screens/widgets/categories_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManagement.lightGrey,
      appBar: AppBar(
        backgroundColor: ColorManagement.primaryPurple,
        elevation: 6,
        shadowColor: ColorManagement.shadowColor,
        centerTitle: false,
        title: Text(
          "حضانة تسنيم الخاصة",
          style: TextManagement.cairoSemiBold.copyWith(
            color: ColorManagement.white,
            fontSize: 26.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            const BoxContainImageAndTexts(),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoriesList(
                    onTap: () => context.pushNamed(Routers.teachers),
                    icon: Icons.person,
                    text: "المعلمون",
                  ),
                  CategoriesList(
                    onTap: () => context.pushNamed(Routers.students),
                    icon: Icons.child_care,
                    text: "الطلاب",
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CategoriesList(
                    onTap: () => context.pushNamed(Routers.subscription),
                    icon: Icons.monetization_on,
                    text: "الاشتراكات",
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
