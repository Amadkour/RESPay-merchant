import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

class SummaryTitle extends StatelessWidget {
  const SummaryTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AutoSizeText(
          tr("Summary"),
          style: TextStyle(
              color: AppColors.blackColor,
              fontWeight: FontWeight.w500,
              fontSize: 24),
        ),
        const Spacer(),
        SvgPicture.asset("assets/icons/transfer/success.svg",
            height: 22, width: 22),
      ],
    );
  }
}
