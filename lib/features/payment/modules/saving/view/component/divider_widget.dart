import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 12,
          width: 1,
          color: AppColors.blackColor,
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
