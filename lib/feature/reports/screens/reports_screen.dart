import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/cubit/reports_cubit.dart';
import 'package:tasneem_sba7ie/feature/reports/logic/cubit/reports_state.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/pie_chart_widget.dart';
import 'package:tasneem_sba7ie/feature/reports/screens/student_reports_screen.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'التقارير',
          style: TextManagement.alexandria20RegularBlack.copyWith(
            color: ColorManagement.mainBlue,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: ColorManagement.white,
        elevation: 0,
        shadowColor: ColorManagement.mainBlue.withOpacity(0.2),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.05.sw, vertical: 0.03.sh),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              ContainerShadow(
                child: Padding(
                  padding: EdgeInsets.all(16.0.sp),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24.sp,
                        backgroundColor:
                            ColorManagement.mainBlue.withOpacity(0.15),
                        child: FaIcon(
                          FontAwesomeIcons.chartPie,
                          size: 24.sp,
                          color: ColorManagement.mainBlue,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'نظرة عامة على التقارير المالية',
                        style: TextManagement.alexandria16BoldMainBlue,
                        semanticsLabel: 'نظرة عامة على التقارير المالية',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 0.02.sh),
              // Pie Chart or State Display
              ContainerShadow(
                child: BlocBuilder<ReportsCubit, ReportsState>(
                  builder: (context, state) {
                    if (state is ReportsLoading) {
                      return Container(
                        padding: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                          color: ColorManagement.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: ColorManagement.mainBlue,
                            strokeWidth: 4.w,
                          ),
                        ),
                      );
                    }
                    if (state is ReportsError) {
                      return Container(
                        padding: EdgeInsets.all(16.sp),
                        decoration: BoxDecoration(
                          color: ColorManagement.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.exclamationTriangle,
                              color: ColorManagement.accentOrange,
                              size: 32.sp,
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              'خطأ في تحميل البيانات: ${state.message}',
                              style: TextManagement.alexandria16RegularBlack
                                  .copyWith(
                                color: ColorManagement.accentOrange,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                    if (state is ReportsLoaded) {
                      return SummaryPieChart(
                        totalMoneyFromSubscriptions: state
                            .summary.totalMoneyFromSubscriptions
                            .toDouble(),
                        remain: state.summary.remain.toDouble(),
                      );
                    }
                    return Container(
                      padding: EdgeInsets.all(16.sp),
                      decoration: BoxDecoration(
                        color: ColorManagement.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.infoCircle,
                            color: ColorManagement.darkGrey.withOpacity(0.5),
                            size: 32.sp,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'لا توجد بيانات لعرضها حاليًا',
                            style: TextManagement.alexandria16RegularBlack
                                .copyWith(
                              color: ColorManagement.darkGrey.withOpacity(0.5),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 0.02.sh),
              // Additional Information Section
              ContainerShadow(
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        context: context,
                        icon: FontAwesomeIcons.userGraduate,
                        label: 'تقارير الطلبة',
                        color: ColorManagement.mainBlue,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const StudentReportsScreen(),
                              ));
                        },
                      ),
                      _buildActionButton(
                        context: context,
                        icon: FontAwesomeIcons.chalkboardTeacher,
                        label: 'تقارير المعلمين',
                        color: ColorManagement.accentOrange,
                        onTap: () {
                          // TODO: Add navigation or action for Teacher Reports
                          // Example: context.pushNamed(Routers.teacherReports);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.sp),
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
              size: 24.sp,
            ),
          ),
          SizedBox(height: 8.h),
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
}
