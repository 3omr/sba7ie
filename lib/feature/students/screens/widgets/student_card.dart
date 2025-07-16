import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tasneem_sba7ie/core/router/router.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/delete_dialog.dart';
import 'package:tasneem_sba7ie/feature/students/data/models/student_model.dart';
import 'package:tasneem_sba7ie/feature/students/logic/students_cubit/students_cubit.dart';

class StudentCard extends StatelessWidget {
  final Student student;
  final int index;
  final StudentsCubit studentsCubit;

  const StudentCard({
    super.key,
    required this.student,
    required this.index,
    required this.studentsCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: InkWell(
        onTap: () {
          context.pushNamed(Routers.studentSubscription, extra: [
            student,
            studentsCubit.getTeacherNameById(student.idTeacher)
          ]);
        },
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
                        student.name ?? '',
                        style: TextManagement.alexandria16RegularBlack,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: 4.h),
                      Text(studentsCubit.getTeacherNameById(student.idTeacher),
                          style: TextManagement.alexandria14RegularDarkGrey),
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
                        context.pushNamed(Routers.updateStudent, extra: [
                          studentsCubit,
                          student,
                          studentsCubit.teachers
                        ]);
                      },
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.trash,
                        size: 20.sp,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteDialog(
                              msg: 'هل أنت متأكد أنك تريد حذف هذا الطالب؟',
                              successMsg: 'تم حذف الطالب بنجاح',
                              title: 'تأكيد الحذف',
                              onDelete: () =>
                                  studentsCubit.deleteStudent(student),
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
