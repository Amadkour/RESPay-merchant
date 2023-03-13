import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';

class MyPinCode extends StatelessWidget {
  const MyPinCode({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
          4,
              (int index) => Container(
              height: (context.width) * 0.14,
              width: (context.width) * 0.14,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: (context.width) * 0.015),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: text.length - 1 < index ? Colors.white : AppColors.otpBorderColor,
                    width: 2),
              ),
              child: text.length - 1 < index
                  ? null
                  : Text(
                text[index],
                style: TextStyle(fontSize: 19, color: AppColors.blackColor),
              ))),
    );
  }
}
