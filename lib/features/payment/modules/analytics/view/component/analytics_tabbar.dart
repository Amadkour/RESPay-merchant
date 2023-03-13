import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';

class AnalyticsTabBarWidget extends StatelessWidget {
  const AnalyticsTabBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      width: context.width,
      child: Column(
        children: <Widget>[
          DefaultTabController(
            length: 3,
            child: TabBar(
              labelColor: AppColors.blackColor,
              labelStyle: bodyStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: bodyStyle.copyWith(
                fontWeight: FontWeight.normal,
              ),
              indicatorColor: AppColors.blackColor,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              tabs: <Tab>[
                Tab(
                  text: tr("income"),
                ),
                Tab(
                  text: tr("expenditure"),
                ),
                Tab(
                  text: tr("spending"),
                )
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
