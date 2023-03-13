import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/widget/images/my_image.dart';

class EmptyWidget extends StatelessWidget {
  final String? message;
  final String subMessage;
  final bool showMessage;
  final bool showIcon;
  final bool showImage;
  final double? height;
  final double? width;
  final Widget? icon;
  final Widget? image;

  const EmptyWidget(
      {this.message,
      this.subMessage = '',
      this.showMessage = true,
      this.showIcon = false,
      this.showImage = true,
      this.height = 100,
      this.width = 400,
      this.icon,
      this.image});

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
                if (showIcon)
                  Material(
                    child: icon ??
                        const Icon(
                          Icons.note_outlined,
                          size: 40,
                        ),
                  ),
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
                      if (subMessage.isNotEmpty)
                        const SizedBox(
                          height: 10,
                        ),
                      AutoSizeText(
                        subMessage,
                        overflow: TextOverflow.ellipsis,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            color: AppColors.textColor3,
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
