import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/constants.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/view/list/page/beneficiary_list.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/controller/gift_cubit/gift_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/view/component/recive_gift.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/custom_app_bar_with_search_bar.dart';

class GiftTabs extends StatelessWidget {
  const GiftTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarWidget: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppBarWithSearchBar(
            serviceType: ServiceType.gift,
          )),
      scaffold: BlocProvider<GiftCubit>.value(
        value: sl<GiftCubit>(),
        child: DefaultTabController(
          length: 2,
          initialIndex: sl<GiftCubit>().currentTapIndex,
          child: MainScaffold(
            scaffold: BlocProvider<BeneficiaryCubit>.value(
              value: sl<BeneficiaryCubit>(),
              child: Column(
                children: <Widget>[
                  Material(
                    color: Colors.white,
                    child: TabBar(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor,
                      ),
                      unselectedLabelColor: AppColors.grayTextColor,
                      labelColor: AppColors.blackColor,
                      indicatorColor: AppColors.blackColor,
                      onTap: (int value) {
                        sl<GiftCubit>().setCurrentTapIndex(value);
                      },
                      tabs: <Widget>[
                        buildTabBarItem("Send Gift"),
                        buildTabBarItem("Received Gift"),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        BeneficiaryList(serviceType: ServiceType.gift),
                        ReceivedGifts(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Tab buildTabBarItem(String label) {
  return Tab(
    key: Key("${(label.replaceAll(" ", "_")).toLowerCase()}_tap"),
    text: tr(label),
  );
}
