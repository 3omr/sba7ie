import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasneem_sba7ie/screens/students/students_screen.dart';
import 'package:tasneem_sba7ie/screens/subscription/subscription_screen.dart';
import 'package:tasneem_sba7ie/screens/teachers/teachers_screen.dart';
import 'package:tasneem_sba7ie/utl/color_management.dart';
import 'package:tasneem_sba7ie/utl/text_management.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/feature/home/screens/widgets/box_contain_image_and_texts.dart';
import 'package:tasneem_sba7ie/feature/home/screens/widgets/categories_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManagement.deepPurple,
        toolbarHeight: 0.12.sh,
        centerTitle: false,
        titleTextStyle:
            TextManagement.cairoS06WBoldWhite.copyWith(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "حضانة تسنيم الخاصة",
            ),
            Text(
              "ازيك يا أباعمر 👋",
              style: TextManagement.cairoS05W500White,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const BoxContainImageAndTexts(),
            SizedBox(height: 0.02.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CategoriesList(
                  onTap: () {
                    Get.to(() => const TeachersScreen());
                  },
                  icon: Icons.person,
                  text: "المعلمون",
                ),
                CategoriesList(
                  onTap: () {
                    Get.to(() => const StudentScreen());
                  },
                  icon: Icons.child_care,
                  text: "الطلاب",
                ),
              ],
            ),
            SizedBox(height: 0.02.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CategoriesList(
                  onTap: () {
                    Get.to(() => const SubscriptionScreen());
                  },
                  icon: Icons.monetization_on,
                  text: "الاشتراكات",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
