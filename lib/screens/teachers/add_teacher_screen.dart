import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasneem_sba7ie/controllers/teachers/add_teacher_controller.dart';
import 'package:tasneem_sba7ie/utl/text_management.dart';

class AddTeacherScreen extends StatelessWidget {
  const AddTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AddTeacherController addTeacherController = Get.put(AddTeacherController());
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة معلم جديد', style: GoogleFonts.cairo()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: addTeacherController.formKey,
          child: Column(
            children: [
              TextFormField(
                controller: addTeacherController.nameController,
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
                keyboardType: TextInputType.number,
                controller: addTeacherController.salaryController,
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
                  if (addTeacherController.formKey.currentState!.validate()) {
                    await addTeacherController.addTeacherButton();
                  }
                },
                child: Text(
                  'إضافة',
                  style: TextManagement.cairoS05W500White,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
