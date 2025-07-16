import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasneem_sba7ie/core/router/router.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/widgets/container_background.dart';
import 'package:tasneem_sba7ie/core/widgets/Error_state_widget.dart';
import 'package:tasneem_sba7ie/core/widgets/empty_state_widget.dart';
import 'package:tasneem_sba7ie/feature/students/logic/students_cubit.dart';
import 'package:tasneem_sba7ie/feature/students/logic/students_state.dart';
import 'package:tasneem_sba7ie/feature/students/data/models/student_model.dart';
import 'package:tasneem_sba7ie/feature/students/screens/widgets/student_card.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManagement.lightGrey,
      appBar: AppBar(
        title: const Text('الطلاب'),
      ),
      body: ContainerBackground(
        child: BlocBuilder<StudentsCubit, StudentsState>(
          builder: (context, state) {
            List<Student> students = context.read<StudentsCubit>().students;
            if (state is StudentsError) {
              return ErrorStateWidget(
                text: state.message,
                reloadFunction: () {
                  context.read<StudentsCubit>().getStudents();
                },
              );
            } else if (state is StudentsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (students.isEmpty) {
              return EmptyStateWidget(
                text: 'لا يوجد طلاب متاحون',
                addButtonText: 'إضافة طالب',
                onPressed: () {
                  context.pushNamed(Routers.addStudent, extra: [
                    context.read<StudentsCubit>(),
                    context.read<StudentsCubit>().teachers
                  ]);
                },
              );
            }
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final student = students[index];
                        final studentsCubit = context.read<StudentsCubit>();
                        return StudentCard(
                          student: student,
                          index: index,
                          studentsCubit: studentsCubit,
                        );
                      },
                      childCount: students.length,
                      addAutomaticKeepAlives: true,
                      addRepaintBoundaries: true,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(Routers.addStudent, extra: [
            context.read<StudentsCubit>(),
            context.read<StudentsCubit>().teachers
          ]);
        },
        backgroundColor: ColorManagement.mainBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
