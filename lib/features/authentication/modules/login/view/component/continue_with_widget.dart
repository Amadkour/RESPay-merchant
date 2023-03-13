
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
/// Custom Text in the login page
/// Part of [LoginPage]
class ContinueWithWidget extends StatelessWidget {
  const ContinueWithWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Divider(
                  color: AppColors.borderColor),
            ),
            Text(
              '    ${tr('continue_with')}    ',
              style: TextStyle(
                  color: AppColors.textColor3,
                  fontSize: context.width * 0.03),
            ),
            Expanded(
                child: Divider(
                    color: AppColors.borderColor)),
          ],
        ),
        SizedBox(
          height: context.height * 0.01,
        ),
      ],
    );
  }
}
