import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/controller/withdraw_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/view/component/amount_text.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/view/component/withdraw_to_card.dart';
import 'package:res_pay_merchant/features/payment/view/component/history_icon.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/view/page/transfer_receipt_page.dart';

class WithdrawView extends StatelessWidget {
  const WithdrawView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WithdrawCubit>(
      create: (BuildContext context) => WithdrawCubit(),
      child: BlocConsumer<WithdrawCubit, WithdrawState>(
        listener: (BuildContext context, WithdrawState state) {
          if (state is WithdrawErrorState) {
            MyToast(state.failure.message);
          }
        },
        builder: (BuildContext context, WithdrawState state) {
          final WithdrawCubit controller = context.read<WithdrawCubit>();

          return MainScaffold(
            scaffold: Scaffold(
              appBar: const MainAppBar(
                  title: 'Withdraw', actions: HistoryIconWidget()),
              body: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        WithdrawAmountWidget(
                          textEditingController: controller.amountController,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),

                        ///withdraw
                        Text(
                          tr('withdraw_to'),
                          style: TextStyle(
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              fontFamily: 'semiBold'),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        const WithdrawToCard(),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(20),
                child: LoadingButton(
                  key: withdrawLoadingButton,
                  enable: controller.enableButton,
                  title: tr('continue_withdraw'),
                  onTap: () async {
                    await _withdraw(controller);
                  },
                  isLoading: false,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Navigate to pin code screen for verification first
  /// when user enters right pin code it performs withdraw task
  /// if the task success it navigates to receipt screen
  Future<void> _withdraw(WithdrawCubit controller) async {
    final ReceiptModel? result = await controller.withDraw();
    if (result != null) {
      CustomNavigator.instance.push(
        routeWidget: TransactionReceiptPage(
          transactionTitle: "withdraw",
          receiptModel: result.copyWith(
            bankAccount: controller.selectedBankAccount,
          ),
          fromWithdraw: true,
          withdrawIcon: 'assets/images/withdraw/bank_icon.svg',
        ),
      );
    }
  }
}
