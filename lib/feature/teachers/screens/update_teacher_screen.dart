import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_cubit.dart';

class UpdateTeacherScreen extends StatefulWidget {
  final Teacher teacher;
  const UpdateTeacherScreen({super.key, required this.teacher});

  @override
  State<UpdateTeacherScreen> createState() => _UpdateTeacherScreenState();
}

class _UpdateTeacherScreenState extends State<UpdateTeacherScreen> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController nameController;
  late final TextEditingController salaryController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController(text: widget.teacher.name);
    salaryController =
        TextEditingController(text: widget.teacher.salary.toString());
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
      backgroundColor: ColorManagement.lightGrey,
      appBar: AppBar(
        title: Text(
          'تعديل معلم',
          style: TextManagement.alexandria24BoldBlack,
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorManagement.lightGrey.withOpacity(0.9),
              ColorManagement.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: ColorManagement.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManagement.mainBlue.withOpacity(0.15),
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: 'الاسم',
                        hintStyle: TextManagement.alexandria16RegularLightGrey,
                        prefixIcon: const Icon(
                          Icons.person,
                          color: ColorManagement.mainBlue,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                      style: TextManagement.alexandria18RegularBlack,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك أدخل اسم المعلم';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: ColorManagement.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManagement.mainBlue.withOpacity(0.15),
                          blurRadius: 8,
                          spreadRadius: 1,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: salaryController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'المرتب',
                        hintStyle: TextManagement.alexandria16RegularLightGrey,
                        prefixIcon: const Icon(
                          Icons.monetization_on,
                          color: ColorManagement.mainBlue,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                      style: TextManagement.alexandria18RegularBlack,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك أدخل المرتب';
                        }
                        if (int.tryParse(value) == null) {
                          return 'يجب إدخال أرقام فقط';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  BlocConsumer<TeacherCubit, TeacherState>(
                    listener: (context, state) {
                      if (state is TeacherAdded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'تم تعديل المعلم بنجاح',
                              style: TextManagement.alexandria16RegularWhite,
                            ),
                            backgroundColor: ColorManagement.mainBlue,
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        context.pop();
                      } else if (state is TeacherError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              state.message,
                              style: TextManagement.alexandria16RegularWhite,
                            ),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state is TeacherLoading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  final updatedTeacher = Teacher(
                                    id: widget.teacher.id,
                                    name: nameController.text,
                                    salary: int.parse(salaryController.text),
                                  );
                                  context.read<TeacherCubit>().updateTeacher(
                                        oldTeacherData: widget.teacher,
                                        newTeacherData: updatedTeacher,
                                      );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManagement.mainBlue,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 16.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 4,
                          shadowColor:
                              ColorManagement.darkGrey.withOpacity(0.3),
                        ),
                        child: state is TeacherLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'تعديل',
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
