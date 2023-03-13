import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards_credit_card/controller/cards_credit_card_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards_credit_card/view/component/credit_card_tab.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards_credit_card/view/component/prepaid_card_tab.dart';

class CardsCreditCardPage extends StatefulWidget {
  final List<CreditCardModel> creditCardModels;

  const CardsCreditCardPage({required this.creditCardModels});

  @override
  State<CardsCreditCardPage> createState() => _CardsCreditCardPageState();
}

class _CardsCreditCardPageState extends State<CardsCreditCardPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MainScaffold(
        appBarWidget: AppBar(
          leading: const BackButton(),
          bottom: TabBar(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              labelColor: AppColors.blackColor,
              indicatorColor: AppColors.blackColor,
              tabs: const <Widget>[
                Tab(
                  text: 'Credit Cards',
                ),
                Tab(
                  text: 'Prepaid Cards',
                )
              ]),
          title: AutoSizeText(
            'Cards',
            style: appBarStyle.copyWith(fontWeight: FontWeight.normal),
          ),
        ),
        scaffold: BlocProvider<CardsCreditCardCubit>(
          create: (BuildContext context) =>
              CardsCreditCardCubit(creditCardModels: widget.creditCardModels),
          child: TabBarView(
            children: <Widget>[
              CreditCardTab(
                creditCardModels: widget.creditCardModels,
              ),
              const PrepaidTab(),
            ],
          ),
        ),
      ),
    );
  }
}
