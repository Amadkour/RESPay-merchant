import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';

class TransactionEmptyStateWidget extends StatelessWidget {
  const TransactionEmptyStateWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Center(
        child: Column(
          children: <Widget>[
            MyImage.svgAssets(
              url: "assets/images/moreBottomsheet/history.svg",
              color: AppColors.borderColor,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 30),
              child: Text(
                tr('no_transactions'),
                style: smallStyle.copyWith(
                  fontWeight: FontWeight.normal,
                  color: AppColors.greyColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
