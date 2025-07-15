import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tasneem_sba7ie/core/router/router.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/widgets/Error_state_widget.dart';
import 'package:tasneem_sba7ie/core/widgets/container_background.dart';
import 'package:tasneem_sba7ie/core/widgets/empty_state_widget.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_cubit/teacher_cubit.dart';
import 'package:tasneem_sba7ie/feature/teachers/screens/widgets/teacher_card.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManagement.lightGrey,
      appBar: AppBar(
        title: const Text(
          'المعلمون',
        ),
      ),
      body: ContainerBackground(
        child: BlocBuilder<TeacherCubit, TeacherState>(
          builder: (context, state) {
            List<Teacher> teachers = context.read<TeacherCubit>().teachers;
            if (state is TeacherError) {
              return ErrorStateWidget(
                text: state.message,
                reloadFunction: () {
                  context.read<TeacherCubit>().getTeachers();
                },
              );
            } else if (state is TeacherLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EmptyTeachers) {
              return EmptyStateWidget(
                text: 'لا يوجد معلمون متاحون',
                addButtonText: 'إضافة معلم',
                onPressed: () {
                  context.pushNamed(Routers.addTeacher,
                      extra: context.read<TeacherCubit>());
                },
              );
            }
            return state is TeacherLoaded || state is TeacherAdded
                ? CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 16.w),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final teacher = teachers[index];
                              return TeacherCard(
                                key: ValueKey(teacher.id),
                                teacher: teacher,
                                index: index,
                                teacherCubit: context.read<TeacherCubit>(),
                              );
                            },
                            childCount: teachers.length,
                            addAutomaticKeepAlives: true,
                            addRepaintBoundaries: true,
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(Routers.addTeacher,
              extra: context.read<TeacherCubit>());
        },
        backgroundColor: ColorManagement.mainBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
