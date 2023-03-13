import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';

class TabWidget extends StatelessWidget {
  final CardsCubit cubit;
  final int index;
  final String tabTitle;

  const TabWidget(
      {required this.cubit, required this.index, required this.tabTitle});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cubit.tapBarIndex == index
          ? null
          : () {
              cubit.onChangeTabBarIndex();
            },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: cubit.tapBarIndex != index
            ? null
            : BoxDecoration(
                color: AppColors.lightGreen.withOpacity(0.2),
                borderRadius: BorderRadius.circular(25),
              ),
        child: AutoSizeText(
          tabTitle,
          style: TextStyle(
              color: cubit.tapBarIndex != index
                  ? AppColors.blackColor
                  : AppColors.greenColor,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
