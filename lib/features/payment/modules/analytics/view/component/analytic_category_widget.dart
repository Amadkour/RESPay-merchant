import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/provider/model/analytics_category.dart';

class AnalyticsCategoryWidget extends StatelessWidget {
  const AnalyticsCategoryWidget({
    super.key,
    required this.category,
    this.width,
    this.margin,
    this.onPressed,
  });
  final AnalyticsCategory category;

  final double? width;
  final EdgeInsets? margin;
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: margin ??
          EdgeInsets.only(
              right: !isArabic ? 15 : 0, left: !isArabic ? 0 : 15, top: 15),
      width: width ?? 170,
      height: 134,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MyImage.svgNetwork(
                    url: category.icon ?? "",
                    color: category.color,
                    height: 38,
                    width: 38,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  AutoSizeText(tr(category.name ?? ""),
                      style: TextStyle(
                          fontFamily: 'Plain',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: AppColors.otpBorderColor)),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      AutoSizeText(
                        category.amount?.toStringAsFixed(2) ?? "",
                        maxFontSize: 20,
                        minFontSize: 14,
                        style: header5Style,
                      ),
                      AutoSizeText(" ${tr('SAR')}",
                          style: TextStyle(
                              fontFamily: 'Bold',
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: AppColors.blackColor)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              onPressed?.call();
            },
            child: MyImage.svgAssets(
              url: 'assets/images/home/menu-dots-vertical.svg',
              height: 16,
              width: 16,
            ),
          )
        ],
      ),
    );
  }
}
