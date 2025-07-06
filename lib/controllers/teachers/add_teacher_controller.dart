import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasneem_sba7ie/controllers/teachers/teachers_controller.dart';
import 'package:tasneem_sba7ie/models/teacher_model.dart';
import 'package:tasneem_sba7ie/repository/teacher_repo.dart';

class AddTeacherController extends GetxController {
  // Text Form
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final salaryController = TextEditingController();

  TeachersController teachersController = Get.find();

  TeacherRepo teacherRepo = TeacherRepo();

  addTeacherButton() async {
    String name = nameController.text;
    int salary = int.parse(salaryController.text);

    int resp = await teacherRepo
        .addTeacher(Teacher(name: name, salary: salary).toJson());

    await teachersController.reloadData();
    if (resp != 0) {
      Get.back();
    }
  }
}
