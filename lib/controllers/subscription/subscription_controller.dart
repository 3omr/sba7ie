import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasneem_sba7ie/sql_database/db.dart';
import 'package:tasneem_sba7ie/utl/getCurrentDate.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionController extends GetxController {
  bool loading = true;
  Db database = Db();
  int? numberOfTeachers;
  int? numberOfStudents;
  int? totalOfSubscription;
  int? totalOfMoney;

  @override
  Future<void> onReady() async {
    await getTeachersNumber();
    await getStudentsNumber();
    await getTotalOfSubscription();
    await getTotalOfMoney();
    getData();
    update();
    loading = false;
    super.onReady();
  }

  getTeachersNumber() async {
    var res =
        await database.readSql("SELECT COUNT(name) AS count FROM teachers");
    numberOfTeachers = res[0]["count"];
  }

  getStudentsNumber() async {
    var res =
        await database.readSql("SELECT COUNT(name) AS count FROM students");
    numberOfStudents = res[0]["count"];
  }

  getTotalOfSubscription() async {
    var res =
        await database.readSql("SELECT SUM(subscription) AS sum FROM students");
    totalOfSubscription = res[0]["sum"] ?? 0;
  }

  getTotalOfMoney() async {
    var res =
        await database.readSql("SELECT SUM(money) AS sum FROM subscriptions");
    totalOfMoney = res[0]["sum"] ?? 0;
  }

  getData() async {
    var res = await database.readSql('''
    SELECT 
      students.name,
      students.subscription,
      subscriptions.date,
      subscriptions.money
    FROM 
      subscriptions
    LEFT JOIN 
      students ON students.id = subscriptions.idStudent
    ''');
    return res;
  }

  sendMsgButton() async {
    String msg = '''------------------------------------------------
    التاريخ                   المدفوع                الاسم 
------------------------------------------------\n''';
    List<Map> data = await getData();
    String table = "";

    for (var e in data) {
      if (getCurrentDate() == e["date"]) {
        table +=
            "${e["date"]}                 ${e["money"]}                      ${e["name"]}\n";
      }
    }
    var whatsappUrl = Uri.parse(
        "whatsapp://send?phone=${"20" + "01008898699"}" +
            "&text=${Uri.encodeComponent(msg + table)}");
    try {
      await launchUrl(whatsappUrl);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
