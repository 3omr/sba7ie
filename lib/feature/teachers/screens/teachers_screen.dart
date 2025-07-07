import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasneem_sba7ie/core/router/router.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_cubit.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManagement.lightGrey,
      appBar: AppBar(
        title: Text(
          'المعلمون',
          style: TextManagement.alexandria20RegularBlack,
        ),
        // backgroundColor: ColorManagement.mainBlue,
        // elevation: 4,
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
        child: BlocBuilder<TeacherCubit, TeacherState>(
          builder: (context, state) {
            List<Teacher> teachers = context.read<TeacherCubit>().teachers;
            if (state is TeacherError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48.sp,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      state.message,
                      style: TextManagement.alexandria18RegularBlack,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        context.read<TeacherCubit>().getTeachers();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorManagement.mainBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: Text(
                        'إعادة المحاولة',
                        style: TextManagement.alexandria16RegularWhite,
                      ),
                    ),
                  ],
                ),
              );
            }
            return state is TeacherLoading
                ? const Center(child: CircularProgressIndicator())
                : state is TeacherLoaded || state is TeacherAdded
                    ? teachers.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person_off,
                                  color: ColorManagement.darkGrey,
                                  size: 64.sp,
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  'لا يوجد معلمون متاحون',
                                  style:
                                      TextManagement.alexandria20RegularBlack,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16.h),
                                ElevatedButton(
                                  onPressed: () {
                                    context.pushNamed(Routers.addTeacher,
                                        extra: context.read<TeacherCubit>());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorManagement.mainBlue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                  child: Text(
                                    'إضافة معلم',
                                    style:
                                        TextManagement.alexandria16RegularWhite,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : CustomScrollView(
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

class TeacherCard extends StatelessWidget {
  final Teacher teacher;
  final int index;

  const TeacherCard({
    super.key,
    required this.teacher,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: ColorManagement.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: ColorManagement.mainBlue.withOpacity(0.15),
                blurRadius: 10,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24.sp,
                  backgroundColor: ColorManagement.mainBlue.withOpacity(0.1),
                  child: Text(
                    '${index + 1}',
                    style: TextManagement.alexandria18RegularBlack,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        teacher.name,
                        style: TextManagement.alexandria18RegularBlack,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: 4.h),
                      Text('المرتب: ${teacher.salary}',
                          style: TextManagement.alexandria16RegularDarkGrey),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.penToSquare,
                        size: 20.sp,
                        color: ColorManagement.mainBlue,
                      ),
                      onPressed: () {
                        context.pushNamed(
                          Routers.updateTeacher,
                          extra: [context.read<TeacherCubit>(), teacher],
                        );
                      },
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.trash,
                        size: 20.sp,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        TeacherCubit teacherCubit =
                            context.read<TeacherCubit>();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'تأكيد الحذف',
                                style: TextManagement.alexandria18RegularBlack,
                              ),
                              content: Text(
                                'هل أنت متأكد أنك تريد حذف هذا المعلم؟',
                                style:
                                    TextManagement.alexandria16RegularDarkGrey,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  child: Text(
                                    'إلغاء',
                                    style:
                                        TextManagement.alexandria16RegularBlack,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.pop();
                                    teacherCubit.deleteTeacher(teacher);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'تم حذف المعلم بنجاح',
                                          style: TextManagement
                                              .alexandria16RegularWhite,
                                        ),
                                        backgroundColor:
                                            ColorManagement.mainBlue,
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'حذف',
                                    style: TextManagement
                                        .alexandria16RegularBlack
                                        .copyWith(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
