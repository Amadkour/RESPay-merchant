import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';

class FilterOptionWidget extends StatelessWidget {
  const FilterOptionWidget({
    super.key,
    required this.title,
    required this.onPressed,
  });
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.greenColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        child: Row(
          children: <Widget>[
            Text(
              tr(title),
              style: bodyStyle.copyWith(
                color: AppColors.greenColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            MyImage.svgAssets(
              url: "assets/icons/transfer/dropdownarrow.svg",
              width: 10,
              height: 5,
              color: AppColors.greenColor,
            ),
          ],
        ),
      ),
    );
  }
}
