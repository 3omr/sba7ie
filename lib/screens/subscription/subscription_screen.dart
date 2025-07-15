// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:tasneem_sba7ie/controllers/subscription/subscription_controller.dart';
// import 'package:tasneem_sba7ie/utl/color_management.dart';
// import 'package:tasneem_sba7ie/utl/contant.dart';
// import 'package:tasneem_sba7ie/utl/text_management.dart';
// import 'package:tasneem_sba7ie/widgets/subscription/header.dart';
// import '../../widgets/container_contain_text_and_number.dart';

// class SubscriptionScreen extends StatelessWidget {
//   const SubscriptionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     SubscriptionController subscriptionController =
//         Get.put(SubscriptionController());
//     return Scaffold(body: SafeArea(
//       child: GetBuilder<SubscriptionController>(builder: (context) {
//         return subscriptionController.loading
//             ? const CircularProgressIndicator()
//             : Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       ContainerContainTextAndNumber(
//                           text: "عدد المعلمون",
//                           number: subscriptionController.numberOfTeachers!),
//                       ContainerContainTextAndNumber(
//                           text: "عدد الطلاب",
//                           number: subscriptionController.numberOfStudents!)
//                     ],
//                   ),
//                   Container(
//                     decoration: BoxDecoration(border: Border.all()),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Header(
//                             text: "الاشتراكات", width: Utl.widthScreen * 0.30),
//                         Header(text: "المدفوع", width: Utl.widthScreen * 0.30),
//                         Header(text: "الباقي", width: Utl.widthScreen * 0.30),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Header(
//                           text: "${subscriptionController.totalOfSubscription}",
//                           width: Utl.widthScreen * 0.30),
//                       Header(
//                           text: "${subscriptionController.totalOfMoney!}",
//                           width: Utl.widthScreen * 0.30),
//                       Header(
//                           text:
//                               "${subscriptionController.totalOfSubscription! - subscriptionController.totalOfMoney!}",
//                           width: Utl.widthScreen * 0.30),
//                     ],
//                   ),
//                   SizedBox(
//                     height: Utl.heightScreen * 0.03,
//                   ),
//                   MaterialButton(
//                     onPressed: () {
//                       subscriptionController.sendMsgButton();
//                     },
//                     child: Container(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: Utl.widthScreen * 0.02),
//                         decoration: BoxDecoration(
//                             border: Border.all(),
//                             borderRadius: BorderRadius.circular(7)),
//                         child: Text(
//                           "ارسال تقرير اليوم",
//                           style: TextManagement.cairoS06WBoldWhite
//                               .copyWith(color: ColorManagement.cyan),
//                         )),
//                   )
//                 ],
//               );
//       }),
//     ));
//   }
// }
