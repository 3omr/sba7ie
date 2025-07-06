import 'package:flutter/material.dart';
import 'package:tasneem_sba7ie/utl/color_management.dart';
import 'package:tasneem_sba7ie/utl/text_management.dart';
import '../utl/contant.dart';

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
      margin: EdgeInsets.symmetric(
          vertical: Utl.heightScreen * 0.005,
          horizontal: Utl.widthScreen * 0.02),
      decoration: BoxDecoration(
          border: Border.all(color: ColorManagement.deepPurple),
          borderRadius: BorderRadius.all(Radius.circular(7))),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: ColorManagement.deepPurple,
          child: Text(
            "${number}",
            style: TextManagement.cairoS05W500White,
          ),
        ),
        title: Text(
          title,
          style: TextManagement.cairoS06WBoldWhite.copyWith(
              color: ColorManagement.deepBlue,
              fontSize: Utl.widthScreen * 0.045),
        ),
        subtitle: Text(
          subTitle,
          style: TextManagement.cairoS05W500White.copyWith(
              color: ColorManagement.grey, fontSize: Utl.widthScreen * 0.025),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                Icons.edit,
                color: ColorManagement.deepPurple,
              ),
              onPressed: onEdite,
            ),
            IconButton(
                icon: Icon(
                  Icons.delete,
                  color: ColorManagement.deepPurple,
                ),
                onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}
