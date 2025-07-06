import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasneem_sba7ie/controllers/subscription/student_subscription_controller.dart';
import 'package:tasneem_sba7ie/utl/color_management.dart';
import 'package:tasneem_sba7ie/utl/contant.dart';
import 'package:tasneem_sba7ie/utl/text_management.dart';
import 'package:tasneem_sba7ie/widgets/subscription/header.dart';
import 'package:tasneem_sba7ie/widgets/subscription/subscriptionDetails.dart';

class StudentSubscriptionScreen extends StatelessWidget {
  const StudentSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    StudentSubscriptionController studentSubscriptionController =
        Get.put(StudentSubscriptionController());
    return Scaffold(
      appBar: AppBar(
        title: Text(studentSubscriptionController.studentData!.name!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(border: Border.all()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Header(text: "الاشتراك", width: Utl.widthScreen * 0.22),
                      Header(text: "المدفوع", width: Utl.widthScreen * 0.22),
                      Header(text: "الباقي", width: Utl.widthScreen * 0.22),
                      Header(text: "تنبيه", width: Utl.widthScreen * 0.22),
                    ],
                  ),
                ),
                GetBuilder<StudentSubscriptionController>(builder: (context) {
                  return studentSubscriptionController.loading == true
                      ? const CircularProgressIndicator()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Header(
                                text: studentSubscriptionController
                                    .studentData!.subscription!
                                    .toString(),
                                width: Utl.widthScreen * 0.22),
                            Header(
                                text: studentSubscriptionController.madfo3
                                    .toString(),
                                width: Utl.widthScreen * 0.22),
                            Header(
                                text:
                                    "${studentSubscriptionController.studentData!.subscription! - studentSubscriptionController.madfo3}",
                                width: Utl.widthScreen * 0.22),
                            SizedBox(
                              width: Utl.widthScreen * 0.22,
                              child: IconButton(
                                  onPressed: () {
                                    studentSubscriptionController
                                        .sendMsgButton();
                                  },
                                  icon: Icon(Icons.textsms_outlined)),
                            ),
                          ],
                        );
                }),
              ],
            ),
            Center(
              child: Text(
                "المدفوعات",
                style: TextManagement.cairoS06WBoldWhite
                    .copyWith(color: ColorManagement.deepPurple),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      right: Utl.widthScreen * 0.03,
                      top: Utl.heightScreen * 0.02),
                  width: Utl.widthScreen * 0.4,
                  height: Utl.heightScreen * 0.1,
                  child: Form(
                      key: studentSubscriptionController.formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller:
                            studentSubscriptionController.moneyController,
                        decoration: const InputDecoration(
                          labelText: 'القسط',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'من فضلك أدخل القسط';
                          }
                          if (int.tryParse(value) == null) {
                            return 'يجب إدخال أرقام فقط';
                          }
                          return null;
                        },
                      )),
                ),
                IconButton(
                    onPressed: () async {
                      if (studentSubscriptionController.formKey.currentState!
                          .validate()) {
                        await studentSubscriptionController.addSubscription();
                      }
                    },
                    icon: Icon(
                      Icons.add_box_outlined,
                      color: ColorManagement.deepBlue,
                      size: Utl.widthScreen * 0.09,
                    ))
              ],
            ),
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: Center(
                child: Row(
                  children: [
                    Header(text: "م", width: Utl.widthScreen * 0.15),
                    Header(text: "المبلغ", width: Utl.widthScreen * 0.25),
                    Header(text: "التاريخ", width: Utl.widthScreen * 0.32),
                    Header(text: "حذف", width: Utl.widthScreen * 0.25),
                  ],
                ),
              ),
            ),
            GetBuilder<StudentSubscriptionController>(builder: (context) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: studentSubscriptionController
                    .studentSubscriptionList.length,
                itemBuilder: (context, index) {
                  return studentSubscriptionController.loading == true
                      ? const CircularProgressIndicator()
                      : SubscriptionDetails(
                          num: index + 1,
                          money: studentSubscriptionController
                              .studentSubscriptionList[index].money!,
                          date: studentSubscriptionController
                              .studentSubscriptionList[index].date!,
                          onTape: () {
                            studentSubscriptionController.deleteSubscription(
                                studentSubscriptionController
                                    .studentSubscriptionList[index].id!);
                          },
                        );
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
