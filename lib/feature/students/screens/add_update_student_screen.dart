import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/app_snack_bars.dart';
import 'package:tasneem_sba7ie/core/widgets/container_background.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/feature/students/data/models/student_model.dart';
import 'package:tasneem_sba7ie/feature/students/logic/students_cubit/students_cubit.dart';
import 'package:tasneem_sba7ie/feature/students/logic/students_cubit/students_state.dart';

class AddUpdateStudentScreen extends StatefulWidget {
  final dynamic student; // Replace with Student? if you have the model
  final List<dynamic>
      teachersList; // Replace with List<Teacher> if you have the model

  const AddUpdateStudentScreen(
      {super.key, this.student, required this.teachersList});

  @override
  State<AddUpdateStudentScreen> createState() => _AddUpdateStudentScreenState();
}

class _AddUpdateStudentScreenState extends State<AddUpdateStudentScreen> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController subscriptionController;
  int? selectedTeacherId;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    subscriptionController = TextEditingController();

    if (widget.student != null) {
      _isUpdating = true;
      nameController.text = widget.student.name ?? '';
      phoneController.text = widget.student.phoneNumber ?? '';
      subscriptionController.text =
          widget.student.subscription?.toString() ?? '';

      bool teacherExists = widget.teachersList
          .any((teacher) => teacher.id == widget.student!.idTeacher);
      if (teacherExists) {
        selectedTeacherId = widget.student.idTeacher;
      } else {
        selectedTeacherId = null;
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    subscriptionController.dispose();
    super.dispose();
  }

  void _saveStudent() {
    if (formKey.currentState!.validate()) {
      final student = Student(
        id: _isUpdating ? widget.student!.id : null,
        name: nameController.text,
        phoneNumber: phoneController.text,
        subscription: int.parse(subscriptionController.text),
        idTeacher: selectedTeacherId,
      );

      if (_isUpdating) {
        context.read<StudentsCubit>().updateStudent(
              oldStudentData: widget.student!,
              newStudentData: student,
            );
      } else {
        context.read<StudentsCubit>().addStudent(student);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManagement.lightGrey,
      appBar: AppBar(
        title: Text(_isUpdating ? 'تعديل طالب' : 'إضافة طالب جديد'),
        centerTitle: true,
      ),
      body: ContainerBackground(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ContainerShadow(
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'الاسم',
                        prefixIcon: Icon(Icons.person),
                      ),
                      style: TextManagement.alexandria18RegularBlack,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك أدخل اسم الطالب';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ContainerShadow(
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        hintText: 'رقم المحمول',
                        prefixIcon: Icon(Icons.phone),
                      ),
                      style: TextManagement.alexandria18RegularBlack,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك أدخل رقم المحمول';
                        } else if (value.length != 11 || value[0] != "0") {
                          return 'ادخل رقم محمول صحيح';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ContainerShadow(
                    child: TextFormField(
                      controller: subscriptionController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'الاشتراك',
                        prefixIcon: Icon(Icons.monetization_on),
                      ),
                      style: TextManagement.alexandria18RegularBlack,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك أدخل قيمة الاشتراك';
                        }
                        if (int.tryParse(value) == null) {
                          return 'يجب إدخال أرقام فقط';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ContainerShadow(
                    child: DropdownButtonFormField<int>(
                      value: selectedTeacherId,
                      style: TextManagement.alexandria16RegularBlack,
                      decoration: InputDecoration(
                        hintStyle: TextManagement.alexandria16RegularDarkGrey,
                        hintText: 'اختار اسم المعلم',
                        prefixIcon: const Icon(Icons.school),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: widget.teachersList.map((teacher) {
                        return DropdownMenuItem<int>(
                          value: teacher.id,
                          child: Text(teacher.name ?? '',
                              style: TextManagement.alexandria16RegularBlack),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTeacherId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value == 0) {
                          return 'من فضلك اختار المعلم';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 32.h),
                  BlocConsumer<StudentsCubit, dynamic>(
                    listener: (context, state) {
                      if (state is StudentsAdded) {
                        AppSnackBars.showSuccessSnackBar(
                            context: context,
                            successMsg: _isUpdating
                                ? 'تم تعديل الطالب بنجاح'
                                : 'تم إضافة الطالب بنجاح');
                        Navigator.of(context).pop();
                      } else if (state is StudentsError) {
                        AppSnackBars.showErrorSnackBar(
                            context: context, errorMsg: state.message);
                      }
                    },
                    builder: (context, state) {
                      final isLoading = state is StudentsLoading;
                      return ElevatedButton(
                        onPressed: isLoading ? null : _saveStudent,
                        child: isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                _isUpdating ? 'تعديل' : 'إضافة',
                                style: TextManagement.alexandria16RegularWhite,
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
