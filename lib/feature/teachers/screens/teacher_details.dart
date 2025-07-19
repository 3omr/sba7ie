import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasneem_sba7ie/core/helper/date_helper.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/core/widgets/horizontal_month_circles.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_management_cubit/teacher_management_cubit.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_management_cubit/teacher_management_state.dart';
import 'package:tasneem_sba7ie/core/widgets/action_button.dart';
import 'package:tasneem_sba7ie/feature/teachers/screens/widgets/teacher_info_card.dart';
import 'package:tasneem_sba7ie/feature/teachers/screens/widgets/teacher_dialogs.dart';

class TeacherDetails extends StatefulWidget {
  final Teacher teacher;
  const TeacherDetails({super.key, required this.teacher});

  @override
  State<TeacherDetails> createState() => _TeacherDetailsState();
}

class _TeacherDetailsState extends State<TeacherDetails> {
  late final TeacherManagementCubit teacherManagementCubit;

  @override
  initState() {
    super.initState();
    teacherManagementCubit = context.read<TeacherManagementCubit>();
    teacherManagementCubit.setTeacher(widget.teacher);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'بيانات المعلم',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.03.sh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Teacher Profile Section ---
              Container(
                padding: EdgeInsets.all(0.04.sw),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManagement.mainBlue.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 0.12.sw,
                      backgroundColor:
                          ColorManagement.mainBlue.withOpacity(0.15),
                      child: FaIcon(
                        FontAwesomeIcons.user,
                        size: 0.14.sw,
                        color: ColorManagement.mainBlue,
                      ),
                    ),
                    SizedBox(width: 0.06.sw),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.teacher.name ?? '',
                            style: TextManagement.alexandria20RegularBlack
                                .copyWith(
                              color: ColorManagement.mainBlue,
                              fontWeight: FontWeight.w800,
                            ),
                            overflow: TextOverflow.ellipsis,
                            semanticsLabel:
                                'اسم المعلم: ${widget.teacher.name}',
                          ),
                          SizedBox(height: 0.01.sh),
                          Text(
                            "المرتب: ${widget.teacher.salary} جنيه",
                            style: TextManagement.alexandria16RegularDarkGrey
                                .copyWith(
                              color: ColorManagement.darkGrey.withOpacity(0.8),
                            ),
                            semanticsLabel:
                                'المرتب: ${widget.teacher.salary} جنيه',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0.04.sh),

              // --- Monthly Navigation ---
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.04.sw, vertical: 0.02.sh),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManagement.mainBlue.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'اختيار الشهر',
                      style: TextManagement.alexandria16BoldMainBlue,
                      semanticsLabel: 'قسم اختيار الشهر',
                    ),
                    const HorizontalMonthCircles(),
                  ],
                ),
              ),
              SizedBox(height: 0.04.sh),

              // --- Action Buttons Section ---
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.04.sw, vertical: 0.02.sh),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: ColorManagement.mainBlue.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("تحكم في الخصومات",
                        style: TextManagement.alexandria16BoldMainBlue),
                    SizedBox(height: 0.04.sh),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ActionButton(
                          icon: FontAwesomeIcons.plus,
                          color: ColorManagement.mainBlue,
                          label: 'إضافة',
                          onPressed: () {
                            TeacherDialogs.showAddAbsenceDiscountDialog(
                              context: context,
                              teacherManagementCubit: teacherManagementCubit,
                            );
                          },
                        ),
                        ActionButton(
                          icon: FontAwesomeIcons.trash,
                          color: Colors.red,
                          label: 'حذف',
                          onPressed: () {
                            TeacherDialogs.showDeleteAbsencesDialog(
                              context: context,
                              teacherManagementCubit: teacherManagementCubit,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 0.04.sh),

              // --- Absence and Lateness Cards ---

              ContainerShadow(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.04.sw, vertical: 0.02.sh),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: ColorManagement.mainBlue.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: BlocBuilder<TeacherManagementCubit,
                      TeacherManagementState>(
                    builder: (context, state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "تفاصيل الغياب والتأخير لشهر ${DateHelper.getArabicMonthName(context.read<TeacherManagementCubit>().currentMonth)}",
                              style: TextManagement.alexandria16BoldMainBlue),
                          SizedBox(height: 0.04.sh),
                          TeacherInfoCard(
                            icon: FontAwesomeIcons.exclamationTriangle,
                            color: Colors.red,
                            text:
                                "عدد أيام الغياب: ${widget.teacher.daysAbsent ?? 0} يوم",
                            gradient: LinearGradient(
                              colors: [
                                Colors.red.withOpacity(0.1),
                                Colors.red.withOpacity(0.05),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          SizedBox(height: 0.03.sh),
                          TeacherInfoCard(
                            icon: FontAwesomeIcons.clock,
                            color: ColorManagement.accentOrange,
                            text:
                                "الخصومات: ${widget.teacher.discounts ?? 0} جنيه",
                            gradient: LinearGradient(
                              colors: [
                                ColorManagement.accentOrange.withOpacity(0.1),
                                ColorManagement.accentOrange.withOpacity(0.05),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          SizedBox(height: 0.04.sh),
                          TeacherInfoCard(
                            icon: FontAwesomeIcons.moneyBill1Wave,
                            color: ColorManagement.mainBlue,
                            text:
                                "المرتب بعد الخصم: ${teacherManagementCubit.teacher.calculateNetSalary()} جنية",
                            gradient: LinearGradient(
                              colors: [
                                ColorManagement.mainBlue.withOpacity(0.1),
                                ColorManagement.mainBlue.withOpacity(0.05),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
