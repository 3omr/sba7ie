import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasneem_sba7ie/core/helper/url_launcher_helper.dart';
import 'package:tasneem_sba7ie/core/helper/write_message_helper.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/feature/students/logic/student_subscription_cubit/student_subscription_cubit.dart';

class SubscriptionInfoSection extends StatelessWidget {
  final StudentSubscriptionCubit studentSubscriptionCubit;
  const SubscriptionInfoSection(
      {super.key, required this.studentSubscriptionCubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.04.sw, vertical: 0.02.sh),
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
      child: BlocBuilder<StudentSubscriptionCubit, StudentSubscriptionState>(
        builder: (context, state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInfoColumn('الاشتراك',
                  studentSubscriptionCubit.student.subscription.toString()),
              _buildInfoColumn(
                  'المدفوع', studentSubscriptionCubit.getPaid().toString()),
              _buildInfoColumn(
                  'الباقي', studentSubscriptionCubit.getRemaining().toString()),
              IconButton(
                onPressed: () {
                  UrlLauncherHelper.sendMessageToPhoneWhatsApp(
                      studentSubscriptionCubit.student.phoneNumber ?? '',
                      WriteMessageHelper.writeMessageToPhoneToGetSubscription(
                          studentSubscriptionCubit.student.subscription ?? 0,
                          studentSubscriptionCubit.getPaid().toInt(),
                          studentSubscriptionCubit.getRemaining().toInt()));
                },
                icon: const FaIcon(FontAwesomeIcons.message),
                color: ColorManagement.mainBlue,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextManagement.alexandria16BoldMainBlue),
        SizedBox(height: 4),
        Text(value, style: TextManagement.alexandria16RegularBlack),
      ],
    );
  }
}
