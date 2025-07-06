import 'package:flutter/material.dart';
import 'package:tasneem_sba7ie/utl/color_management.dart';
import 'package:tasneem_sba7ie/utl/contant.dart';
import 'package:tasneem_sba7ie/widgets/subscription/header.dart';

class SubscriptionDetails extends StatelessWidget {
  final int num;
  final int money;
  final String date;
  final VoidCallback onTape;
  const SubscriptionDetails(
      {super.key,
      required this.num,
      required this.money,
      required this.date,
      required this.onTape});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Header(text: "$num", width: Utl.widthScreen * 0.15),
        Header(text: "$money", width: Utl.widthScreen * 0.25),
        Header(text: date, width: Utl.widthScreen * 0.32),
        SizedBox(
          width: Utl.widthScreen * 0.25,
          child: Center(
            child: IconButton(
                onPressed: onTape,
                icon: Icon(
                  Icons.delete,
                  color: ColorManagement.deepBlue,
                )),
          ),
        )
      ],
    );
  }
}
