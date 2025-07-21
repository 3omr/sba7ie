import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tasneem_sba7ie/core/router/router.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/container_background.dart';
import 'package:tasneem_sba7ie/core/widgets/Error_state_widget.dart';
import 'package:tasneem_sba7ie/core/widgets/empty_state_widget.dart';
import 'package:tasneem_sba7ie/feature/students/logic/students_cubit/students_cubit.dart';
import 'package:tasneem_sba7ie/feature/students/logic/students_cubit/students_state.dart';
import 'package:tasneem_sba7ie/feature/students/data/models/student_model.dart';
import 'package:tasneem_sba7ie/feature/students/screens/widgets/student_card.dart';
import 'package:tasneem_sba7ie/search/student_search.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManagement.lightGrey,
      appBar: AppBar(
        title: const Text('الطلاب'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate:
                    StudentSearch(studentsCubit: context.read<StudentsCubit>()),
              );
            },
            icon: const FaIcon(FontAwesomeIcons.search),
          ),
          IconButton(
            onPressed: () {
              _showFilterDialog(context);
            },
            icon: BlocBuilder<StudentsCubit, StudentsState>(
              builder: (context, state) {
                final hasFilter =
                    context.read<StudentsCubit>().selectedTeacherId != null;
                return FaIcon(
                  FontAwesomeIcons.filter,
                  color: hasFilter ? Theme.of(context).primaryColor : null,
                );
              },
            ),
          ),
        ],
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
              final hasFilter =
                  context.read<StudentsCubit>().selectedTeacherId != null;
              return EmptyStateWidget(
                text: hasFilter
                    ? 'لا يوجد طلاب لهذا المعلم'
                    : 'لا يوجد طلاب متاحون',
                addButtonText: hasFilter ? 'إزالة التصفية' : 'إضافة طالب',
                onPressed: () {
                  if (hasFilter) {
                    context.read<StudentsCubit>().clearFilter();
                  } else {
                    context.pushNamed(Routers.addStudent, extra: [
                      context.read<StudentsCubit>(),
                      context.read<StudentsCubit>().teachers
                    ]);
                  }
                },
              );
            }
            return Column(
              children: [
                // Filter indicator
                BlocBuilder<StudentsCubit, StudentsState>(
                  builder: (context, state) {
                    final studentsCubit = context.read<StudentsCubit>();
                    final teacherId = studentsCubit.selectedTeacherId;

                    if (teacherId != null) {
                      final teacherName =
                          studentsCubit.getTeacherNameById(teacherId);
                      return Container(
                        margin: EdgeInsets.all(16.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const FaIcon(FontAwesomeIcons.filter, size: 16),
                            SizedBox(width: 8.w),
                            Text(
                              'المعلمة: $teacherName',
                              style: TextManagement.alexandria14RegularBlack,
                            ),
                            SizedBox(width: 8.w),
                            GestureDetector(
                              onTap: () {
                                studentsCubit.clearFilter();
                              },
                              child: Icon(
                                Icons.close,
                                size: 18.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                Expanded(
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                            vertical: 16.h, horizontal: 16.w),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final student = students[index];
                              final studentsCubit =
                                  context.read<StudentsCubit>();
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
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    final studentsCubit = context.read<StudentsCubit>();
    final teachers = studentsCubit.teachers;
    final selectedTeacherId = studentsCubit.selectedTeacherId;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'تصفية الطلاب',
          style: TextManagement.alexandria16BoldMainBlue,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // All Students option
            RadioListTile<int?>(
              title: Text(
                'جميع الطلاب',
                style: TextManagement.alexandria14RegularBlack,
              ),
              value: null,
              groupValue: selectedTeacherId,
              onChanged: (value) {
                studentsCubit.clearFilter();
                Navigator.of(context).pop();
              },
            ),
            const Divider(),
            // Teachers list
            ...teachers
                .map((teacher) => RadioListTile<int?>(
                      title: Text(
                        teacher.name ?? '',
                        style: TextManagement.alexandria14RegularBlack,
                      ),
                      value: teacher.id,
                      groupValue: selectedTeacherId,
                      onChanged: (value) {
                        if (value != null) {
                          studentsCubit.filterByTeacher(value);
                        }
                        Navigator.of(context).pop();
                      },
                    ))
                .toList(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'إلغاء',
              style: TextManagement.alexandria16RegularBlack
                  .copyWith(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
