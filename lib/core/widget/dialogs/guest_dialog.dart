import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';

import 'package:res_pay_merchant/core/services/navigation.dart';

import 'package:res_pay_merchant/core/widget/dialogs/custom_success_dialog.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class GuestDialog extends StatelessWidget {
  const GuestDialog({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        CustomSuccessDialog.instance.show(
          context: context,
          canClose: true,
          title: tr('guest_mode'),
          subTitle: tr(
              'You are in guest mode, please login or sign up to use all features'),
          onPressedFirstButton: () async {
            /// add these methods to reset dependencies again when login
            await sl.reset();
            await setUp();
            CustomNavigator.instance.pushNamed(RoutesName.login);
          },
          onPressedSecondButton: () {},
          imageUrl: 'assets/images/home/guestDialog.svg',
          firstButtonText: tr('login'),
          bottomWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                tr("don't_have_account"),
                style: TextStyle(
                  color: AppColors.textColor3,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Plain',
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                width: 5,
              ),
              InkWell(
                key: goToSignupKey,
                onTap: () {
                  CustomNavigator.instance.pushNamed(RoutesName.register);
                },
                child: Text(
                  tr('sign_up'),
                  style: const TextStyle(
                    fontFamily: 'Plain',
                    color: Colors.blue,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: AbsorbPointer(
        ignoringSemantics: true,
        child: child,
      ),
    );
  }
}
