import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';

class WesternUnionLocalSummary extends StatelessWidget {
  const WesternUnionLocalSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: context.height,
        padding: const EdgeInsets.all(18),
        color: AppColors.lightWhite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            SizedBox(
              height: 160,
            )
          ],
        ),
      ),
    );
  }
}
