import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/features/authentication/modules/onboarding/controller/on_boarding_controller_cubit.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class OnBoardingBottomWidget extends StatelessWidget {
  const OnBoardingBottomWidget(
      {super.key,
      required this.cubit});

  final OnBoardingControllerCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width - 48,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: LoadingButton(
                  key: goToLoginKey,
                  onTap: () async {
                    await cubit.install();

                    /// New Approach
                    CustomNavigator.instance.pushNamed(RoutesName.login);
                  },
                  title: tr('log_in'),
                  backgroundColor: AppColors.blackColor,
                  isLoading: false,
                  topPadding: 0,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: LoadingButton(
                key: goToSignupKey,
                isLoading: false,
                topPadding: 0,
                onTap: () async {
                  await cubit.install();
                  CustomNavigator.instance.pushNamed(
                    RoutesName.register,
                  );
                },
                title: tr('sign_up'),
                fontColor: AppColors.blackColor,
                backgroundColor: Colors.transparent,
                borderColor: AppColors.borderColor,
              )),
            ],
          ),
          SizedBox(
            height: context.height * 0.04,
          ),
          InkWell(
            onTap: () async {
              await cubit.install();
              CustomNavigator.instance.pushNamedAndRemoveUntil(
                RoutesName.dashboard,
                arguments: false,
                (Route<dynamic> route) => false,
              );
            },
            child: Text(
              tr('guest_mode'),
              style: TextStyle(
                  color: AppColors.blueTextColor,
                  fontSize: context.width * 0.035,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
