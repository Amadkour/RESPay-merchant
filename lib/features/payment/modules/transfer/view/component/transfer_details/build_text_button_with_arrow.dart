import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';

class TextButtonWithArrow extends StatelessWidget {
  const TextButtonWithArrow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomNavigator.instance.pop();
      },
      child: Row(
        children: <Widget>[
          Text(
            tr("Edit"),
            style: TextStyle(
                color: AppColors.blueColor,
                fontWeight: FontWeight.w500,
                fontSize: 13),
          ),
          const SizedBox(
            width: 5,
          ),
          Icon(
            // <-- Icon
            !isArabic
                ? Icons.keyboard_arrow_right_rounded
                : Icons.keyboard_arrow_left_rounded,
            color: AppColors.blueColor,
            size: 18.0,
          )
        ],
      ),
    );
  }
}
