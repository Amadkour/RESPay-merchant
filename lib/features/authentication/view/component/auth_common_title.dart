import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';

class StartupTexts extends StatelessWidget {
  final String title;
  final String subTitle;

  const StartupTexts(
      {super.key,  required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: context.width * 0.05, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: context.height * 0.005),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: context.width * 0.038,
            color: const Color(0xff5A6367),
            height: 1.6
          ),
        ),
        SizedBox(
          height: context.height * 0.05,
        ),
      ],
    );
  }
}
