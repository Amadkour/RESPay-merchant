import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

class CheckWidget extends StatelessWidget {
  const CheckWidget({
    super.key,
    this.isChecked = false,
  });
  final bool isChecked;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsetsDirectional.only(end: 5),
      decoration: BoxDecoration(
        color: isChecked ? AppColors.greenColor : AppColors.systemBodyColor,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.check,
        size: 18,
        color: Colors.white,
      ),
    );
  }
}
