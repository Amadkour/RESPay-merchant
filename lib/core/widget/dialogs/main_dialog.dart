import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/res/utils/extenstions.dart';

import 'package:res_pay_merchant/core/widget/images/my_image.dart';

class MainDialog {
  final String? imagePNG;
  final double? imageHeight;
  final double? imageWidth;
  final String? dialogTitle;
  final String? dialogSupTitle;
  final String? endTitle;
  void Function()? onPressedText;

  MainDialog({
    this.imagePNG,
    this.dialogTitle,
    this.dialogSupTitle,
    this.endTitle,
    this.imageHeight,
    this.imageWidth,
    this.onPressedText,
  }) {
    showDialog(
        context: globalKey.currentContext!,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: SizedBox(
              width: context.width * 0.95,
              height: context.height * 0.58,
              child: Padding(
                padding: const EdgeInsets.only(left: 23, right: 23),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyImage.assets(
                      url: imagePNG!,
                      height: imageHeight!,
                      width: imageWidth!,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AutoSizeText(
                      tr(dialogTitle!),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'semiBold',
                        color: AppColors.blackColor,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    InkWell(
                      key: goBackKey,
                      onTap: onPressedText,
                      child: AutoSizeText(
                        tr(dialogSupTitle!),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Plain',
                          color: AppColors.blackColor.withOpacity(.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
