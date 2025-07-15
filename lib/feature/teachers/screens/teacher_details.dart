import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tasneem_sba7ie/core/helper/date_helper.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/app_snack_bars.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/core/widgets/horizontal_month_circles.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_management_cubit/teacher_management_cubit.dart';
import 'package:tasneem_sba7ie/feature/teachers/logic/teacher_management_cubit/teacher_management_state.dart';

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
                            "المرتب: ${widget.teacher.salary}",
                            style: TextManagement.alexandria16RegularDarkGrey
                                .copyWith(
                              color: ColorManagement.darkGrey.withOpacity(0.8),
                            ),
                            semanticsLabel: 'المرتب: ${widget.teacher.salary}',
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
                      style: TextManagement.alexandria18BoldMainBlue,
                      semanticsLabel: 'قسم اختيار الشهر',
                    ),
                    SizedBox(height: 0.015.sh),
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
                        style: TextManagement.alexandria18BoldMainBlue),
                    SizedBox(height: 0.04.sh),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(
                          icon: FontAwesomeIcons.plus,
                          color: ColorManagement.mainBlue,
                          label: 'إضافة',
                          onPressed: () {
                            _showAddAbsenceDiscountDialog();
                          },
                        ),
                        // _buildActionButton(
                        //   icon: FontAwesomeIcons.penToSquare,
                        //   color: Colors.green,
                        //   label: 'تعديل',
                        //   onPressed: () {
                        //     // Handle edit action
                        //   },
                        // ),
                        _buildActionButton(
                          icon: FontAwesomeIcons.trash,
                          color: Colors.red,
                          label: 'حذف',
                          onPressed: () {
                            _showDeleteAbsencesDialog();
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
                              style: TextManagement.alexandria18BoldMainBlue),
                          SizedBox(height: 0.04.sh),
                          _buildInfoCard(
                            icon: FontAwesomeIcons.exclamationTriangle,
                            color: Colors.red,
                            text:
                                "عدد أيام الغياب: ${widget.teacher.daysAbsent ?? 0}",
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
                          _buildInfoCard(
                            icon: FontAwesomeIcons.clock,
                            color: ColorManagement.accentOrange,
                            text:
                                "عدد أيام التأخير: ${widget.teacher.lateDays ?? 0}",
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
                          _buildInfoCard(
                            icon: FontAwesomeIcons.moneyBill1Wave,
                            color: ColorManagement.mainBlue,
                            text: "المرتب بعد الخصومات: 1500 جنية",
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

  // Helper method to build action buttons with labels
  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required String label,
    VoidCallback? onPressed,
  }) {
    return Semantics(
      button: true,
      label: label,
      child: Column(
        children: [
          GestureDetector(
            onTap: onPressed,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: EdgeInsets.all(0.03.sw),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: FaIcon(
                icon,
                color: color,
                size: 0.08.sw,
              ),
            ),
          ),
          SizedBox(height: 0.015.sh),
          Text(
            label,
            style: TextManagement.alexandria16RegularBlack.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build information cards
  Widget _buildInfoCard({
    required IconData icon,
    required Color color,
    required String text,
    required LinearGradient gradient,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.02.sh),
      decoration: BoxDecoration(
        gradient: gradient,
        border: Border.all(color: color.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            radius: 0.07.sw,
            child: FaIcon(
              icon,
              color: color,
              size: 0.08.sw,
            ),
          ),
          SizedBox(width: 0.05.sw),
          Expanded(
            child: Text(
              text,
              style: TextManagement.alexandria16RegularBlack.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorManagement.black.withOpacity(0.9),
              ),
              semanticsLabel: text,
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteAbsencesDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'حذف الخصومات',
            style: TextManagement.alexandria18RegularBlack,
          ),
          content: Text(
            'هل تريد حذف الخصومات لشهر ${DateHelper.getArabicMonthName(teacherManagementCubit.currentMonth)} فقط أم لكل الشهور؟',
            style: TextManagement.alexandria16RegularDarkGrey,
          ),
          actions: <Widget>[
            TextButton(
              child:
                  Text('إلغاء', style: TextManagement.alexandria16RegularBlack),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('حذف الشهر الحالي',
                  style: TextManagement.alexandria16RegularWhite
                      .copyWith(color: Colors.red)),
              onPressed: () async {
                await teacherManagementCubit.deleteTeacherAbsences(
                    isAllMonths: false);
                AppSnackBars.showSuccessSnackBar(
                  context: context,
                  successMsg: 'تم حذف الخصومات لهذا الشهر بنجاح',
                );
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('حذف كل الشهور',
                  style: TextManagement.alexandria16RegularWhite
                      .copyWith(color: Colors.red)),
              onPressed: () async {
                await teacherManagementCubit.deleteTeacherAbsences(
                    isAllMonths: true);
                AppSnackBars.showSuccessSnackBar(
                  context: context,
                  successMsg: 'تم حذف جميع الخصومات بنجاح',
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showAddAbsenceDiscountDialog() {
    final TextEditingController absenceController = TextEditingController();
    final TextEditingController discountController = TextEditingController();
    DateTime currentDate = DateTime.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'إضافة غياب وخصومات أخرى',
            style: TextManagement.alexandria18RegularBlack,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ContainerShadow(
                  child: TextField(
                    controller: absenceController,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(hintText: "عدد أيام الغياب"),
                  ),
                ),
                SizedBox(height: 0.01.sh),
                ContainerShadow(
                  child: TextField(
                    controller: discountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "خصومات أخرى"),
                  ),
                ),
                SizedBox(height: 0.02.sh),
                SizedBox(
                  width: 300.w,
                  height: 400.h,
                  child: MonthPicker(
                    selectedCellTextStyle:
                        TextManagement.alexandria16RegularWhite,
                    minDate: DateTime(2025, 7),
                    maxDate: DateTime(2026, 12),
                    initialDate: currentDate,
                    onDateSelected: (value) {
                      currentDate = value;
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:
                  Text('إلغاء', style: TextManagement.alexandria16RegularBlack),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child:
                  Text('إضافة', style: TextManagement.alexandria16RegularWhite),
              onPressed: () async {
                await teacherManagementCubit.setTeacherAbsenceAndLateDays(
                  absentDays: int.tryParse(absenceController.text) ?? 0,
                  lateDays: int.tryParse(discountController.text) ?? 0,
                  month: DateFormat('MM-yyyy').format(currentDate),
                );
                absenceController.clear();
                discountController.clear();
                AppSnackBars.showSuccessSnackBar(
                    // ignore: use_build_context_synchronously
                    context: context,
                    successMsg: 'تم إضافة الغياب والخصومات بنجاح');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
