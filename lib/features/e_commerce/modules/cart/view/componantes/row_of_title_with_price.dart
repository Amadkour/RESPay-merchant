import 'package:flutter/material.dart';

import 'package:res_pay_merchant/core/res/theme/colors.dart';

class RowOfTitleWithPrice extends StatelessWidget {
  const RowOfTitleWithPrice(
      {super.key, required this.title, required this.price});

  final String title;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.blackColor),
          ),
          const Spacer(),
          Text(
            "${price.toStringAsFixed(2)} SAR",
            style: TextStyle(
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          )
        ],
      ),
    );
  }
}
