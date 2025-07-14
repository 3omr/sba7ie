import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tasneem_sba7ie/core/router/router.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/delete_dialog.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_cubit.dart';

class TeacherCard extends StatelessWidget {
  final Teacher teacher;
  final int index;
  final TeacherCubit teacherCubit;

  const TeacherCard({
    super.key,
    required this.teacher,
    required this.index,
    required this.teacherCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: InkWell(
        onTap: () {
          context.pushNamed(Routers.teacherDetails,
              extra: [context.read<TeacherCubit>(), teacher]);
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
                        teacher.name ?? '',
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
                          extra: [teacherCubit, teacher],
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
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteDialog(
                              msg: 'هل أنت متأكد أنك تريد حذف هذا المعلم؟',
                              successMsg: 'تم حذف المعلم بنجاح',
                              title: 'تأكيد الحذف',
                              onDelete: () => teacherCubit.deleteTeacher(
                                teacher,
                              ),
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
