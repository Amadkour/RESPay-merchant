import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

import 'package:res_pay_merchant/core/res/theme/colors.dart';

class GeneralAddNewWidget extends StatelessWidget {
  const GeneralAddNewWidget(
      {super.key,
      required this.onPressed,
      this.width = 130,
      required this.title});

  final double width;
  final String? title;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 15, right: !isArabic ? 15 : 0, left: !isArabic ? 0 : 15),
      child: DottedBorder(
        radius: const Radius.circular(12),
        borderType: BorderType.RRect,
        dashPattern: const <double>[8],
        color: const Color(0xffACB1B3),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            width: width,
            height: 134,
            padding: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.add,
                  size: 35,
                  color: AppColors.blueTextColor,
                ),
                const SizedBox(
                  height: 8,
                ),
                title != null
                    ? AutoSizeText(
                        title!,
                        minFontSize: 7,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.blueTextColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          fontFamily: 'Plain',
                          decoration: TextDecoration.underline,
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
