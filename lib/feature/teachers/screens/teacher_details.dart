import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/container_shadow.dart';
import 'package:tasneem_sba7ie/core/widgets/horizontal_month_circles.dart';
import 'package:tasneem_sba7ie/feature/teachers/data/models/teacher_model.dart';

class TeacherDetails extends StatelessWidget {
  final Teacher teacher;
  const TeacherDetails({super.key, required this.teacher});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بيانات المعلم'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.04.sw, vertical: 0.04.sh),
          child: Column(
            children: [
              Row(children: [
                CircleAvatar(
                  radius: 0.1.sw,
                  backgroundColor: ColorManagement.mainBlue.withOpacity(0.1),
                  child: FaIcon(
                    size: 0.12.sw,
                    color: ColorManagement.mainBlue,
                    FontAwesomeIcons.user,
                  ),
                ),
                SizedBox(
                  width: 0.05.sw,
                ),
                Flexible(
                  child: Column(children: [
                    Text(
                      teacher.name,
                      style: TextManagement.alexandria24BoldBlack,
                    ),
                    Text(
                      "المرتب: ${teacher.salary}",
                      style: TextManagement.alexandria16RegularDarkGrey,
                    ),
                  ]),
                )
              ]),
              SizedBox(
                height: 0.02.sh,
              ),
              Divider(thickness: 1.sp, color: ColorManagement.mainBlue),
              const HorizontalMonthCircles(),
              Divider(thickness: 1.sp, color: ColorManagement.mainBlue),
              SizedBox(
                height: 0.02.sh,
              ),
              ContainerShadow(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorManagement.white,
                      border: Border.all(color: Colors.red),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.02.sw, vertical: 0.02.sh),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.red.withOpacity(0.1),
                          child: FaIcon(
                            FontAwesomeIcons.exclamation,
                            color: Colors.red,
                            size: 0.07.sw,
                          ),
                        ),
                        SizedBox(
                          width: 0.02.sw,
                        ),
                        Text(
                          "عدد أيام الغياب: 7",
                          style: TextManagement.alexandria18RegularBlack,
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              ContainerShadow(
                child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorManagement.white,
                      border: Border.all(color: ColorManagement.accentOrange),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 0.02.sw, vertical: 0.02.sh),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              ColorManagement.accentOrange.withOpacity(0.1),
                          child: FaIcon(
                            FontAwesomeIcons.exclamation,
                            color: ColorManagement.accentOrange,
                            size: 0.07.sw,
                          ),
                        ),
                        SizedBox(
                          width: 0.02.sw,
                        ),
                        Text(
                          "عدد أيام التأخير: 3",
                          style: TextManagement.alexandria18RegularBlack,
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
