import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasneem_sba7ie/controllers/teachers/teachers_controller.dart';
import 'package:tasneem_sba7ie/models/teacher_model.dart';
import 'package:tasneem_sba7ie/repository/teacher_repo.dart';

class UpdateTeacherController extends GetxController {
  // Text Form field
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final salaryController = TextEditingController();

  Teacher? oldTeacherDate;

  TeacherRepo teacherRepo = TeacherRepo();

  TeachersController teachersController = Get.find();
  @override
  void onInit() {
    super.onInit();
    oldTeacherDate = Get.arguments;
    nameController.text = oldTeacherDate!.name!;
    salaryController.text = oldTeacherDate!.salary!.toString();
  }

  updateTeacher() async {
    String name = nameController.text;
    int salary = int.parse(salaryController.text);

    int resp = await teacherRepo.updateTeacher(
        oldTeacherDate!, Teacher(name: name, salary: salary).toJson());

    await teachersController.reloadData();
    if (resp != 0) {
      Get.back();
    }
  }
}
