import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasneem_sba7ie/controllers/teachers/update_teacher_controller.dart';
import 'package:tasneem_sba7ie/utl/text_management.dart';

class UpdateTeacherScreen extends StatelessWidget {
  const UpdateTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UpdateTeacherController updateTeacherController =
        Get.put(UpdateTeacherController());

    return Scaffold(
      appBar: AppBar(
        title: Text('تعديل معلم', style: GoogleFonts.cairo()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: updateTeacherController.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: updateTeacherController.nameController,
                decoration: const InputDecoration(
                  labelText: 'الاسم',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك أدخل اسم المعلم';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: updateTeacherController.salaryController,
                decoration: const InputDecoration(
                  labelText: 'المرتب',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك أدخل المرتب';
                  }
                  if (int.tryParse(value) == null) {
                    return 'يجب إدخال أرقام فقط';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (updateTeacherController.formKey.currentState!
                      .validate()) {
                    await updateTeacherController.updateTeacher();
                  }
                },
                child: Text('تعديل', style: TextManagement.cairoS05W500White),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
