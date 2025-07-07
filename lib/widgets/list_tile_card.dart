import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasneem_sba7ie/core/theme/color_management.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';

class ListTileCard extends StatelessWidget {
  final int number;
  final String title;
  final String subTitle;
  final VoidCallback onEdite;
  final VoidCallback onDelete;
  const ListTileCard(
      {super.key,
      required this.number,
      required this.title,
      required this.subTitle,
      required this.onEdite,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.005.sh, horizontal: 0.02.sw),
      decoration: BoxDecoration(
          border: Border.all(color: ColorManagement.mainBlue),
          borderRadius: BorderRadius.all(Radius.circular(7.r))),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: ColorManagement.mainBlue,
          child: Text(
            "$number",
            style: TextManagement.alexandria16RegularBlack
                .copyWith(color: ColorManagement.white, fontSize: 0.025.sh),
          ),
        ),
        title: Text(
          title,
          style: TextManagement.alexandria16RegularBlack.copyWith(),
        ),
        subtitle: Text(
          subTitle,
          style: TextManagement.alexandria16RegularBlack.copyWith(
            color: ColorManagement.darkGrey,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: ColorManagement.mainBlue,
              ),
              onPressed: onEdite,
            ),
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: ColorManagement.mainBlue,
                ),
                onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}
