import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/res/theme/font_styles.dart';

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Text(
        tr("edit"),
        style: smallStyle.copyWith(
          color: AppColors.blueColor,
        ),
      ),
      label: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 15,
        color: AppColors.blueColor,
      ),
    );
  }
}
