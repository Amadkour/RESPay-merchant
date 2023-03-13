import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_details/build_text_button_with_arrow.dart';

class TitleWithSubtitleInfo extends StatelessWidget {
  final bool haveButtonInRow;
  final String title;
  final String? subtitle;
  const TitleWithSubtitleInfo(
      {super.key,
      required this.haveButtonInRow,
      required this.title,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: AutoSizeText(tr(title),
            style: TextStyle(
                fontSize: 14,
                color: AppColors.grayTextColor,
                fontWeight: FontWeight.w500)),
        subtitle: Row(
          children: <Widget>[
            AutoSizeText(
              subtitle ?? "",
              style: TextStyle(
                  fontSize: 14,
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            haveButtonInRow
                ? const TextButtonWithArrow()
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
