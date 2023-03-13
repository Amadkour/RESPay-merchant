import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/controllers/faq_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/provider/model/faq_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/view/component/faq_card.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/view/component/search_card.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class FAQsPage extends StatelessWidget {
  final FaqModel? faqs;
  final String? title;

  const FAQsPage({super.key, this.faqs, this.title});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FaqCubit>(
      create: (BuildContext context) => FaqCubit(faqs: faqs, title: title),
      child: BlocBuilder<FaqCubit, FaqState>(
        builder: (BuildContext context, FaqState state) {
          final FaqCubit controller = context.read<FaqCubit>();

          return MainScaffold(
            scaffold: Scaffold(
              appBar: MainAppBar(
                onBack: () {
                  CustomNavigator.instance.popUntil(
                    (Route<dynamic> route) => <String>[
                      RoutesName.authDashboard,
                      RoutesName.dashboard
                    ].contains(route.settings.name),
                  );
                },
                title: context.read<FaqCubit>().pageTitle ?? tr('faq'),
              ),
              body: FaqScreenBody(controller: controller),
            ),
          );
        },
      ),
    );
  }
}

class FaqScreenBody extends StatelessWidget {
  const FaqScreenBody({
    super.key,
    required this.controller,
  });

  final FaqCubit controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SearchCard(controller.userName ?? "", controller.onChangeSearch, controller),
            const FrequentlyCard(),
            const FooterContactUsTextButton(),
            const SizedBox(
              height: 18,
            )
          ],
        ),
      ),
    );
  }
}

class FooterContactUsTextButton extends StatelessWidget {
  const FooterContactUsTextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          tr("no_answer"),
          style: TextStyle(color: AppColors.blackColor, fontSize: 14, fontFamily: 'plain'),
        ),
        InkWell(
          child: Text(
            tr("contact_us"),
            style: TextStyle(
              color: AppColors.blueTextColor,
              fontSize: 14,
              fontFamily: 'plain',
              decoration: TextDecoration.underline,
            ),
          ),
          onTap: () => CustomNavigator.instance
              .pushNamed(RoutesName.support, arguments: GlobalKey<FormState>()),
        )
      ],
    );
  }
}
