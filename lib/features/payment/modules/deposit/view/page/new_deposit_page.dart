import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
import 'package:res_pay_merchant/features/payment/modules/amount/view/components/transfer_amount_textfield.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/controller/deposit_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/view/component/card_icon_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/view/component/card_number_dotes_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_sucess_dialog.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class NewDepositPage extends StatelessWidget {
  const NewDepositPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DepositCubit>(
      create: (BuildContext context) => DepositCubit(),
      child: Builder(builder: (BuildContext context) {
        final DepositCubit depositController = context.read<DepositCubit>();
        return MainScaffold(
          appBarWidget: MainAppBar(
            title: tr("deposit"),
          ),
          scaffold: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                    top: 24, bottom: 20, left: 20, right: 20),
                padding: const EdgeInsets.symmetric(vertical: 24),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 9,
                    bottom: 7,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 46),
                          child: TransactionAmountTextField(
                            key: amountTextFieldKey,
                            autoFocus: true,
                            textAlign: TextAlign.center,
                            controller: depositController.amountController,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              tr('select_deposit'),
                              style: TextStyle(
                                  fontFamily: 'Plain',
                                  fontSize: 12,
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 8,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: BlocBuilder<DepositCubit, DepositState>(
                            builder:
                                (BuildContext context, DepositState state) {
                              final CreditCardModel? card =
                                  depositController.card;
                              return ListTile(
                                key: chooseDepositCardButtonKey,
                                onTap: () {
                                  CustomNavigator.instance.pushNamed(
                                    RoutesName.depositVia,
                                    arguments: depositController,
                                  );
                                },
                                leading: card != null
                                    ? CardIconWidget(
                                        type: card.type!,
                                      )
                                    : null,
                                title: Text(
                                  card == null
                                      ? tr("select")
                                      : card.type?.toLowerCase() ?? "",
                                  style: smallStyle.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: card != null
                                    ? CardNumberDotesWidget(
                                        cardNumber: card.cardNumber ?? "",
                                      )
                                    : null,
                                trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.black,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: ColoredBox(
            color: Colors.white,
            child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 28,
                  right: 28,
                  bottom: 20,
                ),
                child: BlocConsumer<DepositCubit, DepositState>(
                  listener: (BuildContext context, DepositState state) async {
                    if (state is DepositFailure) {
                      MyToast(state.failure.message);
                    }
                    if (state is DepositCreated) {
                      await TransferSuccessDialog.instance.show(context,
                          receiptModel: state.receiptModel.copyWith(
                            cardModel: depositController.card,
                          ));
                    }
                  },
                  builder: (BuildContext context, DepositState state) =>
                      LoadingButton(
                    key: depositSubmitButtonKey,
                    topPadding: 0,
                    enable: depositController.buttonEnabled,
                    isLoading: state is DepositLoading,
                    onTap: () async {
                      await depositController.create();
                     
                    },
                    title: tr('deposit_money'),
                  ),
                )),
          ),
        );
      }),
    );
  }
}
