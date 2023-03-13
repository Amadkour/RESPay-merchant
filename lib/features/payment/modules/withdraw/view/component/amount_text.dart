import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/amount/controller/transaction_amount_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/amount/view/components/transfer_amount_textfield.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';

class WithdrawAmountWidget extends StatelessWidget {
  const WithdrawAmountWidget({super.key, required this.textEditingController});
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ///amount
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 72),
          child: BlocProvider<TransactionAmountCubit>.value(
            value: sl<TransactionAmountCubit>(),
            child: BlocBuilder<TransactionAmountCubit, TransactionAmountState>(
              builder: (BuildContext context, Object? state) {
                //TODO i remove this and replace it with amount textfield widget
                // return ParentTextField(
                //   key: withdrawText,
                //   controller: textEditingController,
                //   validator: MoneyAmountValidator().getValidation(),
                //   keyboardType: TextInputType.number,
                //   style: currencyFieldStyle,
                //   verticalPadding: 0,
                //   padding: 0,
                //   decoration: InputDecoration(
                //     contentPadding: EdgeInsets.zero,
                //     enabledBorder: UnderlineInputBorder(
                //       borderSide: BorderSide(
                //         color: AppColors.blackColor.withOpacity(0.2),
                //       ),
                //     ),
                //     suffixIconConstraints: const BoxConstraints(
                //       maxWidth: 60,
                //       maxHeight: 40,
                //     ),
                //     suffixIcon: CurrencyDropdown(
                //       onChanged: (Currency c) {
                //         amountCubit.changeCurrency(c);
                //       },
                //       value: amountCubit.currentCurrency,
                //     ),
                //     hintText: tr("0.00"),
                //     hintStyle: currencyFieldStyle.copyWith(
                //       color: Colors.grey,
                //     ),
                //   ),
                // );

                return TransactionAmountTextField(
                  key: withdrawText,
                  controller: textEditingController,
                  textAlign: TextAlign.center,
                  withCurrency: false,
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text((sl<TransactionHistoryCubit>().wallet?.total ?? 0).toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.greenColor,
                  )),
              Text(tr('sar'),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.greenColor,
                  )),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              tr('available_balance').toUpperCase(),
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColors.withdrawTextColor.withOpacity(0.54),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
