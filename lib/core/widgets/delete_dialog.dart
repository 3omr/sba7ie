import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tasneem_sba7ie/core/theme/text_management.dart';
import 'package:tasneem_sba7ie/core/widgets/app_snack_bars.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.onDelete,
    this.title,
    this.msg,
    this.successMsg,
  });

  final VoidCallback onDelete;
  final String? title;
  final String? msg;
  final String? successMsg;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title ?? 'تأكيد الحذف',
        style: TextManagement.alexandria18RegularBlack,
      ),
      content: Text(
        msg ?? "هل تريد حذف العنصر؟",
        style: TextManagement.alexandria16RegularDarkGrey,
      ),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: Text(
            'إلغاء',
            style: TextManagement.alexandria16RegularBlack,
          ),
        ),
        TextButton(
          onPressed: () {
            context.pop();
            onDelete();
            AppSnackBars.showSuccessSnackBar(
                context: context,
                successMsg: successMsg ?? 'تم حذف العنصر بنجاح');
          },
          child: Text(
            'حذف',
            style: TextManagement.alexandria16RegularBlack.copyWith(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
