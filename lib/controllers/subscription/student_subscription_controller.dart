import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasneem_sba7ie/models/student_model.dart';
import 'package:tasneem_sba7ie/models/subscription_model.dart';
import 'package:tasneem_sba7ie/repository/subscription_repo.dart';
import 'package:tasneem_sba7ie/services/data_service.dart';
import 'package:tasneem_sba7ie/utl/contant.dart';
import 'package:tasneem_sba7ie/utl/getCurrentDate.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentSubscriptionController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final moneyController = TextEditingController();

  Student? studentData;
  bool loading = true;
  List<Subscription> studentSubscriptionList = [];

  DataService dataService = Get.find();
  SubscriptionRepo subscriptionRepo = SubscriptionRepo();

  int madfo3 = 0;

  @override
  void onInit() {
    super.onInit();
    studentData = Get.arguments;
  }

  getStudentSubscription() async {
    studentSubscriptionList = dataService.subscriptionsList
        .where((element) => studentData!.id == element.idStudent)
        .toList();
    for (Subscription e in studentSubscriptionList) {
      madfo3 += e.money!;
    }
    loading = false;
    update();
  }

  reloadDate() async {
    loading = true;
    await dataService.getSubscription();
    studentSubscriptionList = dataService.subscriptionsList
        .where((element) => studentData!.id == element.idStudent)
        .toList();

    madfo3 = 0;
    for (Subscription e in studentSubscriptionList) {
      madfo3 += e.money!;
    }
    loading = false;
    update();
  }

  @override
  void onReady() {
    super.onReady();
    getStudentSubscription();
  }

  addSubscription() async {
    int money = int.parse(moneyController.text);
    String date = getCurrentDate();

    await subscriptionRepo.addSubscription(
        Subscription(date: date, idStudent: studentData!.id, money: money)
            .toJson());

    await reloadDate();

    moneyController.text = "";
    update();
  }

  deleteSubscription(int subscriptionId) {
    Utl.dialogWindow(
        onPressed: () async {
          subscriptionRepo.deleteSubscription(subscriptionId);
          await reloadDate();
          Get.back();
          update();
        },
        title: "حذف",
        buttonText: "موافق",
        msg: "هل تريد حذف القسط");
  }

  sendMsgButton() async {
    int baqi = studentData!.subscription! - madfo3;
    var whatsappUrl = Uri.parse(
        "whatsapp://send?phone=${"20" + studentData!.phoneNumber!}" +
            "&text=${Uri.encodeComponent('''
            حضانة الجمعية الشرعية
            نبلغكم أنه متبقي $baqi جنيه من الاشتراك السنوي
            ''')}");
    try {
      await launchUrl(whatsappUrl);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
