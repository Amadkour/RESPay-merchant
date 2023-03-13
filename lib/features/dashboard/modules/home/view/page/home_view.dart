import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/dialogs/guest_dialog.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/controller/hom_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/view/component/general_add_new_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/view/component/home_appbar.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/view/component/my_analytics.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/view/component/my_cards.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/view/component/my_transactions.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/view/component/wallet_card.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/view/component/welcome_card.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.isAuthorized});

  final bool isAuthorized;

  @override
  Widget build(BuildContext context) {
    final Widget body = Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const HomeWelcomeCard(),
            const SizedBox(height: 25),

            ///wallet
            WalletCard(isAuthorized: isAuthorized),

            ///cards
            if (isAuthorized) ...<Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
                child: MyCardsPage(),
              ),

              ///last transactions
              const TransactionsWidget(),
            ] else
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        tr('my_cards'),
                        style: TextStyle(
                            fontSize: 16,
                            color: context.theme.primaryColor,
                            fontFamily: 'Bold',
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 130,
                        // width: context.width/3,
                        child: GeneralAddNewWidget(
                            title: tr("add_new_card"),
                            onPressed: () {
                              CustomNavigator.instance.pushNamed(
                                  RoutesName.cardInfo,
                                  arguments: <String, dynamic>{
                                    "callback": () =>
                                        CustomNavigator.instance.pop(),
                                  });
                            }),
                      ),
                    ]),
              ),

            ///analysis
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: AnalyticsWidget(isAuthorized: isAuthorized),
            ),
          ],
        ));
    return BlocProvider<HomCubit>.value(
      value: sl<HomCubit>(),
      child: MainScaffold(
        appBarWidget: const HomeAppBarWidget(),
        scaffold: SingleChildScrollView(
          child: isAuthorized ? body : GuestDialog(child: body),
        ),
      ),
    );
  }
}
