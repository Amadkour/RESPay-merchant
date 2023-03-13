import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/enum/gender.dart';

class CelebrityFilterChip extends StatelessWidget {
  const CelebrityFilterChip({
    super.key,
    required this.value,
    required this.onPressed,
    required this.active,
  });
  final CelebrityGender value;
  final ValueChanged<CelebrityGender> onPressed;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onPressed(value);
      },
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 80,
        ),
        margin: const EdgeInsetsDirectional.only(end: 4),
        decoration: BoxDecoration(
          color: active
              ? AppColors.greenColor.withOpacity(0.2)
              : AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 13),
        child: Center(
          child: Text(
            tr(value.name),
            style: bodyStyle.copyWith(
              color: active ? AppColors.greenColor : AppColors.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
