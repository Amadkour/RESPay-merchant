import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/card_item_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/controller/deposit_cubit.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class DepositViaPage extends StatelessWidget {
  const DepositViaPage({super.key, required this.cubit});
  final DepositCubit cubit;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<CardsCubit>.value(
          value: sl<CardsCubit>(),
        ),
        BlocProvider<DepositCubit>.value(value: cubit),
      ],
      child: MainScaffold(
        appBarWidget: MainAppBar(
          title: tr("deposit_via"),
        ),
        scaffold: BlocBuilder<CardsCubit, CardsState>(
          builder: (BuildContext context, CardsState state) {
            final CardsCubit cardController = context.read<CardsCubit>();

            if (state is CardsLoading) {
              return const Center(
                child: NativeLoading(),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  key: depositViaScrollViewKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24,
                          bottom: 12,
                        ),
                        child: Text(
                          tr("select_card"),
                          style: paragraphStyle,
                        ),
                      ),
                      if (cardController.creditCardModels.isEmpty)
                        EmptyWidget(
                          message: tr('no_cards'),
                        )
                      else
                        BlocBuilder<DepositCubit, DepositState>(builder:
                            (BuildContext context, DepositState state) {
                          return Column(
                            children: List<Widget>.generate(
                                cardController.creditCardModels.length,
                                (int index) {
                              final CreditCardModel card = cardController
                                  .creditCardModels
                                  .elementAt(index);
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: CardItemWidget(
                                    card: card,
                                    groupValue: cubit.card,
                                    onChanged: (CreditCardModel card) {
                                      cubit.setCard(card);
                                      CustomNavigator.instance.pop();
                                    },
                                  ),
                                ),
                              );
                            }),
                          );
                        }),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 20),
                        child: InkWell(
                          key: addNewCreditCardButtonKey,
                          onTap: () {
                            cardController.resetCardValues();
                            // showCustomBottomSheet(
                            //   context: context,
                            //   body: PaymentMethodSheet(
                            //     hasBankAccounts: true,
                            //     onAdded: () {
                            //       CustomNavigator.instance.pop();
                            //     },
                            //   ),
                            //   hasButtons: false,
                            //   title: "add_new",
                            // );
                            CustomNavigator.instance.pushNamed(
                                RoutesName.cardInfo,
                                arguments: <String, dynamic>{
                                  "callback": () =>
                                      CustomNavigator.instance.pop(),
                                });
                          },
                          child: DottedBorder(
                            radius: const Radius.circular(16),
                            borderType: BorderType.RRect,
                            dashPattern: const <double>[12],
                            color: AppColors.borderColor,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.add,
                                    color: AppColors.blueColor2,
                                  ),
                                  Text(
                                    tr('add_new_card'),
                                    style: TextStyle(
                                      color: AppColors.darkBlueColor,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
