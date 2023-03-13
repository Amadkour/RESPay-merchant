import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/widget/images/my_image.dart';

class MyErrorWidget extends StatelessWidget {
  final String? message;

  final bool showMessage;

  final bool showImage;
  final double? height;
  final double? width;

  final Widget? image;

  const MyErrorWidget({
    this.message,
    this.showMessage = true,
    this.showImage = true,
    this.height = 100,
    this.width = 400,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: (height ?? 200) / 2),
            child: Column(
              children: <Widget>[
                if (showImage)
                  Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                      ),
                      image ??
                          MyImage.svgAssets(
                            url: 'assets/images/empty.svg',
                            width: width!,
                            height: height!,
                          ),
                    ],
                  ),
                if (showMessage)
                  Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                      ),
                      AutoSizeText(
                        message ?? tr('empty'),
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: AppColors.blackColor,
                            fontFamily: 'Bold',
                            fontSize: 18),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
