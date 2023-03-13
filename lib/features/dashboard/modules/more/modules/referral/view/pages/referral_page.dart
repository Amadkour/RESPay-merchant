import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/controller/referral_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/view/components/invite_friend.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/referral/view/components/referrals.dart';

class ReferralPage extends StatelessWidget {
  const ReferralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReferralCubit>(
       create: (BuildContext context) => sl<ReferralCubit>(),
      child: BlocBuilder<ReferralCubit,ReferralState>(
        builder: (BuildContext context, ReferralState state) {
          return DefaultTabController(
            length: 2,
            child: MainScaffold(
                appBarWidget: const MainAppBar(
                    title: "referral"
                ),
              scaffold: Column(
                children: <Widget>[
                  Material(
                    color: Colors.white,
                    child: TabBar(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: AppColors.blackColor,
                      ),
                      unselectedLabelColor: AppColors.blackColor,
                      labelColor: AppColors.blackColor,
                      indicatorColor: AppColors.blackColor,
                      onTap: (int value) {

                      },
                      tabs: <Widget>[
                        buildTabBarItem("Invite Friend"),
                        buildTabBarItem("Referrals"),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        InviteFriend(),
                        ReferralsTab()
                      ],
                    ),
                  ),
                ],
              )
            ),
          );
        },
      ),
    );
  }

  Tab buildTabBarItem(String label) {
    return Tab(
      key: Key("${(label.replaceAll(" ", "_")).toLowerCase()}_tap"),
      text: tr(label),
    );
  }
}
