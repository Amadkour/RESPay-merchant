import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/res/theme/decoration_values.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';

class TransferItem extends StatelessWidget {
  const TransferItem({
    super.key,
    required this.transferType,
  });

  final String transferType;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
            color: AppColors.lightWhite.withOpacity(0.2),
            borderRadius: defaultBorderRadius,
            border: Border.all(
              color: AppColors.borderColor,
            )),
        child: Row(
          children: <Widget>[
            const SizedBox(
              width: 14,
            ),
            CircleAvatar(
              radius: 15, // Image radius
              backgroundColor: Colors.white,
              child: MyImage.assets(
                  url:
                      "assets/images/transfer/types/${transferType.replaceAll(" ", "_").toLowerCase()}.png"),
            ),
            const SizedBox(
              width: 8,
            ),
            AutoSizeText(transferType,
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.w500),
                maxFontSize: 15,
                maxLines: 1,
                minFontSize: 8),
            const Spacer(),
            !isArabic
                ? MyImage.svgAssets(
                    url: "assets/icons/transfer/rightarrow.svg",
                    height: 25,
                  )
                : RotatedBox(
                    quarterTurns: 2,
                    child: MyImage.svgAssets(
                      url: "assets/icons/transfer/rightarrow.svg",
                      height: 25,
                    ),
                  ),
            const SizedBox(
              width: 14,
            ),
          ],
        ));
  }
}
