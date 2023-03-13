import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';

class OnBoardingWidget extends StatelessWidget {
  final String imageUrl;
  final String titleText;
  final String firstText;

  const OnBoardingWidget({
    super.key,
    required this.imageUrl,
    required this.titleText,
    required this.firstText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MyImage.svgAssets(
          url: imageUrl,
          width: context.width * 0.8,
          height: context.height * 0.37,
        ),
        SizedBox(
          height: context.height * 0.04,
        ),
        Text(
          titleText,
          style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: context.width * 0.05),
        ),
        SizedBox(
          height: context.height * 0.03,
        ),
        AutoSizeText(
          firstText,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: context.width * 0.043,
            color: const Color(0xff5A6367),
          ),
        ),
      ],
    );
  }
}
