import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:res_pay_merchant/core/res/utils/extenstions.dart';

import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/row_title_widget.dart';

import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

/// TODO: Refactor
class CheckoutWidget extends StatelessWidget {
  const CheckoutWidget({
    super.key,
    required this.imageUrl,
    required this.blackTextTitle,
    this.addressTitle,
    this.subTitle,
    this.title,
    this.onTapBlueText,
    this.blueTextTitle,
    this.showContent = true,
    this.emptyWidget,
    this.imageHeight,
    this.imageWidth,
    this.radioWidget,
    this.showBlueText = true,
  });

  final String imageUrl;
  final bool showContent;
  final String blackTextTitle;
  final String? blueTextTitle;
  final String? addressTitle;
  final Widget? subTitle;
  final Widget? radioWidget;
  final Widget? emptyWidget;
  final Widget? title;
  final VoidCallback? onTapBlueText;
  final double? imageHeight;
  final double? imageWidth;
  final bool showBlueText;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        shadowColor: Colors.grey,
        elevation: 20,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8, top: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RowTitleWidget(
                          blackText: blackTextTitle,
                          showBlueText: showBlueText,
                          blueText: blueTextTitle ?? tr('change'),
                          onTapBlueText: onTapBlueText,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(
                          color: AppColors.borderColor,
                          thickness: 2,
                        ),
                        SizedBox(
                          height: subTitle == null ? 8 : 0,
                        ),
                      ],
                    ),
                  ),
                  if (showContent)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          MyImage.svgAssets(
                            url: imageUrl,
                            height: imageHeight ?? context.width * 0.1,
                            width: imageWidth ?? context.width * 0.1,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          title == null
                              ? Flexible(
                                  child: AutoSizeText(
                                    addressTitle!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(
                                            fontSize: 12,
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.w500),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              title ?? const SizedBox.shrink(),
                              subTitle ?? const SizedBox.shrink(),
                            ],
                          ),
                          const SizedBox(
                            width: 17,
                          ),
                        ],
                      ),
                    ),
                  if (!showContent) Center(child: emptyWidget)
                ],
              ),
              radioWidget != null
                  ? Positioned(
                      right: isArabic ? null : 10,
                      left: isArabic ? 10 : null,
                      top: 50,
                      child: Center(child: radioWidget),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
