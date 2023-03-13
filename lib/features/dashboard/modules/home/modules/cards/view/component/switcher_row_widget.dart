import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/widget/custom_switch.dart';

class SwitcherRowWidget extends StatelessWidget {
  final bool? switchValue;
  final VoidCallback? onToggleSwitch;
  final String title;
  final String imageUrl;
  final Widget? trailingWidget;

  const SwitcherRowWidget(
      {this.switchValue,
      required this.title,
      required this.imageUrl,
      this.trailingWidget,
      this.onToggleSwitch});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.lightBlue,
            borderRadius: BorderRadius.circular(30)),
        child: SvgPicture.asset(
          imageUrl,
          width: context.width * 0.05,
          height: context.width * 0.05,
        ),
      ),
      title: AutoSizeText(
        title,
      ),
      trailing: trailingWidget ??
          CustomSwitch(
            value: switchValue!,
            onChanged: (bool value) {
              onToggleSwitch!();
            },
          ),
    );
  }
}
