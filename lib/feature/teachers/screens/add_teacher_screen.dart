import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasneem_sba7ie/core/router/router.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_cubit.dart';

class AddTeacherScreen extends StatefulWidget {
  const AddTeacherScreen({super.key});

  @override
  State<AddTeacherScreen> createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController nameController;
  late final TextEditingController salaryController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    salaryController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة معلم جديد', style: GoogleFonts.cairo()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
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
                controller: salaryController,
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
              BlocConsumer<TeacherCubit, TeacherState>(
                listener: (context, state) {
                  if (state is TeacherAdded) {
                    context.pop(
                      Routers.teachers,
                    );
                  } else if (state is TeacherError) {}
                },
                builder: (context, state) {
                  if (state is TeacherLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final teacher = Teacher(
                          name: nameController.text,
                          salary: int.parse(salaryController.text),
                        );
                        context.read<TeacherCubit>().addTeacher(teacher);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    child: Text(
                      'إضافة',
                      style: TextManagement.alexandria16RegularBlack.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
