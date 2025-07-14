import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/app_snack_bars.dart';
import 'package:tasneem_sba7ie/core/widgets/container_background.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_cubit.dart';

class AddUpdateTeacherScreen extends StatefulWidget {
  // Make the teacher parameter nullable to indicate add or update mode
  final Teacher? teacher;

  const AddUpdateTeacherScreen({super.key, this.teacher});

  @override
  State<AddUpdateTeacherScreen> createState() => _AddUpdateTeacherScreenState();
}

class _AddUpdateTeacherScreenState extends State<AddUpdateTeacherScreen> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController nameController;
  late final TextEditingController salaryController;

  // A flag to determine if we are in update mode
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    salaryController = TextEditingController();

    // Check if a teacher object was passed, indicating update mode
    if (widget.teacher != null) {
      _isUpdating = true;
      nameController.text = widget.teacher!.name ?? '';
      salaryController.text = widget.teacher!.salary.toString();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    salaryController.dispose();
    super.dispose();
  }

  // Unified save method
  void _saveTeacher() {
    if (formKey.currentState!.validate()) {
      // Create a Teacher object from current form values
      final teacher = Teacher(
        // If updating, retain the original teacher's ID
        // Otherwise, the ID will be null for a new teacher (and usually assigned by the backend)
        id: _isUpdating ? widget.teacher!.id : null,
        name: nameController.text,
        salary: int.parse(salaryController.text),
      );

      if (_isUpdating) {
        // Call the update method of the Cubit
        context.read<TeacherCubit>().updateTeacher(
              oldTeacherData: widget.teacher!, // original teacher data
              newTeacherData: teacher, // new teacher data
            );
      } else {
        // Call the add method of the Cubit
        context.read<TeacherCubit>().addTeacher(teacher);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManagement.lightGrey,
      appBar: AppBar(
        title: Text(
          // Dynamically change the title based on mode
          _isUpdating ? 'تعديل معلم' : 'إضافة معلم جديد',
        ),
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
                        prefixIcon: Icon(
                          Icons.person,
                        ),
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
                  ContainerShadow(
                    child: TextFormField(
                      controller: salaryController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'المرتب',
                        prefixIcon: Icon(
                          Icons.monetization_on,
                        ),
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
                        AppSnackBars.showSuccessSnackBar(
                            context: context,
                            successMsg: _isUpdating
                                ? 'تم تعديل المعلم بنجاح'
                                : 'تم إضافة المعلم بنجاح');
                        context.pop(); // Go back after success
                      } else if (state is TeacherError) {
                        AppSnackBars.showErrorSnackBar(
                            context: context, errorMsg: state.message);
                      }
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed:
                            state is TeacherLoading ? null : _saveTeacher,
   
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
                                // Dynamically change button text
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
