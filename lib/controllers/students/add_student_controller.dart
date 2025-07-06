import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasneem_sba7ie/controllers/students/students_controller.dart';
import 'package:tasneem_sba7ie/models/student_model.dart';
import 'package:tasneem_sba7ie/repository/student_repo.dart';
import 'package:tasneem_sba7ie/services/data_service.dart';

class AddStudentController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final subscriptionController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final teacherNameController = TextEditingController();

  DataService dataService = Get.find();
  StudentRepo studentRepo = StudentRepo();
  StudentsController studentsController = Get.find();

  int idTeacher = 0;
  getIdTeacher(value) {
    idTeacher = value;
    update();
  }

  addStudentButton() async {
    String name = nameController.text;
    String phoneNumber = phoneNumberController.text;
    int subscription = int.parse(subscriptionController.text);

    int resp = await studentRepo.addStudent(Student(
            name: name,
            phoneNumber: phoneNumber,
            subscription: subscription,
            idTeacher: idTeacher)
        .toJson());
    await studentsController.reloadData();
    if (resp != 0) {
      Get.back();
    }
  }
}
