import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class EmptyBankAccounts extends StatelessWidget {
  const EmptyBankAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: AppColors.borderColor,
      child: Container(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: <Widget>[
            MyImage.svgAssets(
              url: 'assets/images/withdraw/bank_icon.svg',
              height: 48,
              width: 48,
            ),
            const SizedBox(
              height: 11,
            ),
            Text(
              tr('No_bank'),
              style: TextStyle(
                  color: AppColors.textColor3,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  fontFamily: 'Plain'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 11,
            ),
            InkWell(
              onTap: () {
                CustomNavigator.instance.pushNamed(RoutesName.addBankAccount);
              },
              child: Text(
                tr('Add_bank'),
                style: TextStyle(
                  color: AppColors.blueTextColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  fontFamily: 'Plain',
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
