import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onBack,
  });

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: "back",
      onPressed: () {
        if (onBack != null) {
          onBack?.call();
        } else {
          CustomNavigator.instance.pop();
        }
      },
      icon: RotatedBox(
        quarterTurns: isArabic ? 2 : 0,
        child: SvgPicture.asset("assets/icons/back.svg"),
      ),
    );
  }
}
