import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/public_module/focus_node_model.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/keyboard_actions_widget.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/card_number_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/cvv_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/expire_date_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/name_text_field.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/view/component/card_icon_widget.dart';

class CardInfoPage extends StatelessWidget {
  const CardInfoPage({super.key, required this.arguments});

  final Map<String, dynamic> arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CardsCubit>.value(
      value: sl<CardsCubit>(),
      child: BlocBuilder<CardsCubit, CardsState>(
        builder: (BuildContext context, CardsState state) {
          final CardsCubit cardController = context.read<CardsCubit>();
          return MainScaffold(
            appBarWidget: MainAppBar(
              title: tr('add_new'),
            ),
            scaffold: KeyboardActionsWidget(
              focusNodeModels: <FocusNodeModel>[
                FocusNodeModel(
                  focusNode: cardController.cardNumberFocusNode,
                ),
                FocusNodeModel(
                  focusNode: cardController.cvvFocusNode,
                ),
                FocusNodeModel(
                  focusNode: cardController.validUntilFocusNode,
                ),
                FocusNodeModel(
                  focusNode: cardController.nameFocusNode,
                ),
              ],
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(
                        top: 32,
                        left: 20,
                        right: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            tr('add_new_credit_card'),
                            style: header5Style,
                          ),
                          Text(
                            tr('for_ease_of_transaction'),
                            style: bodyStyle.copyWith(
                              color: AppColors.systemBodyColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              children: const <Widget>[
                                CardIconWidget(
                                  type: "visa",
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: CardIconWidget(
                                    type: "mastercard",
                                  ),
                                ),
                                CardIconWidget(
                                  type: "mada",
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25, bottom: 20),
                            child: CreditCardNumberTextField(
                              key: cardNumberTextFieldKey,
                              onChanged: cardController.setCardNumber,
                              focusNode: cardController.cardNumberFocusNode,
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: CvvTextField(
                                  key: cvvTextFieldKey,
                                  onChanged: cardController.setCvv,
                                  focusNode: cardController.cvvFocusNode,
                                ),
                              ),
                              const SizedBox(
                                width: 22,
                              ),
                              Expanded(
                                child: BlocBuilder<CardsCubit, CardsState>(
                                  buildWhen: (CardsState previous, CardsState current) {
                                    return current is CardInfoChanged;
                                  },
                                  builder: (BuildContext context, CardsState state) =>
                                      ExpireDateTextField(
                                    key: dateTextFieldKey,
                                    date: cardController.date,
                                    focusNode: cardController.validUntilFocusNode,
                                    controller: TextEditingController.fromValue(
                                      TextEditingValue(
                                        text: cardController.date,
                                      ),
                                    ),
                                    onChanged: cardController.setExpireDate,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: NameTextField(
                              minLength: 4,
                              key: nameOnCardTextFieldKey,
                              onChanged: cardController.setHolderName,
                              hint: tr("name_on_card"),
                              focusNode: cardController.nameFocusNode,
                              title: tr("name_on_card"),
                              color: AppColors.backgroundColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(left: 22, right: 22, bottom: 20),
              child: BlocConsumer<CardsCubit, CardsState>(
                listener: (BuildContext context, CardsState state) {
                  if (state is CardsFailure) {
                    MyToast(state.failure.message);
                  }
                  if (state is CardCreatedState) {
                    (arguments['callback'] as VoidCallback).call();
                  }
                },
                builder: (BuildContext context, CardsState state) => LoadingButton(
                  key: confirmAddCardButtonKey,
                  isLoading: state is CreateCardLoading,
                  title: tr("save"),
                  enable: cardController.enableCreateCardButton,
                  onTap: () {
                    cardController.createCard();
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
