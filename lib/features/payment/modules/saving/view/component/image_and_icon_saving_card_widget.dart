import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';

class ImageAndIconSavingCardWidget extends StatelessWidget {
  final String? imageUrl;
  final String? title;
  final VoidCallback? onTap;

  const ImageAndIconSavingCardWidget(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          MyImage.svgAssets(
            url: imageUrl,
            height: context.width * 0.04,
            width: context.width * 0.04,
          ),
          const SizedBox(
            width: 4,
          ),
          AutoSizeText(
            title!,
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: context.width * 0.03),
          ),
        ],
      ),
    );
  }
}
