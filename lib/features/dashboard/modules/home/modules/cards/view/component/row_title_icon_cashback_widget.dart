import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

class RowTitleIconCashbackWidget extends StatelessWidget {
  const RowTitleIconCashbackWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          AutoSizeText(
            title,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                color: AppColors.withdrawTextColor,
                fontSize: 12,
                fontWeight: FontWeight.bold),
          ),
          Container(
            width: 10,
            height: 3,
            decoration: BoxDecoration(
                color: AppColors.withdrawTextColor,
                borderRadius: BorderRadius.circular(15)),
          )
        ],
      ),
    );
  }
}
