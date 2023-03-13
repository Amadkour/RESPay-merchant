import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/provider/module/shop_model.dart';

class CategoryFilter extends StatelessWidget {
  const CategoryFilter({
    super.key,
    required this.value,
    required this.onPressed,
  });

  final ShopCategories value;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 80,
        ),
        margin: const EdgeInsetsDirectional.only(end: 4),
        decoration: BoxDecoration(
          color: value.isSelect ? AppColors.greenColor.withOpacity(0.2) : const Color(0xffF7F7F7),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 13),
        child: Center(
          child: Text(
            tr(value.name ?? (value.uuid ?? '')),
            style: bodyStyle.copyWith(
              color:
                  value.isSelect ? AppColors.greenColor : AppColors.secondaryColor.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }
}
