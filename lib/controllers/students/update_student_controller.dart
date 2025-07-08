import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasneem_sba7ie/controllers/students/students_controller.dart';
import 'package:tasneem_sba7ie/feature/students/data/models/student_model.dart';
import 'package:tasneem_sba7ie/feature/students/data/repos/student_repo.dart';
import 'package:tasneem_sba7ie/services/data_service.dart';

class UpdateStudentController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final subscriptionController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final teacherNameController = TextEditingController();

  Student? oldStudentData;

  DataService dataService = Get.find();
  StudentRepo studentRepo = StudentRepo();
  StudentsController studentsController = Get.find();

  int idTeacher = 0;
  getIdTeacher(value) {
    idTeacher = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();

    oldStudentData = Get.arguments;
    nameController.text = oldStudentData!.name!;
    subscriptionController.text = oldStudentData!.subscription!.toString();
    phoneNumberController.text = oldStudentData!.phoneNumber!;
  }

  updateStudentButton() async {
    String name = nameController.text;
    String phoneNumber = phoneNumberController.text;
    int subscription = int.parse(subscriptionController.text);
  }
}
