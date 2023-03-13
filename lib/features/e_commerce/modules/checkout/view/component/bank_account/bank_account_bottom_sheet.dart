import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/base_bottom_sheet.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/view/component/bank_account/bank_method_sheet.dart';

import 'package:res_pay_merchant/features/payment/modules/withdraw/controller/withdraw_cubit.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

void showBankAccountMethodBottomSheet({required BuildContext context}) {
  showCustomBottomSheet(
    context: context,
    padding: EdgeInsets.zero,
    margin: EdgeInsets.zero,
    hasButtons: false,
    body: SafeArea(
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            child: Material(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: const <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          ///My Bank accounts
          const SizedBox(
            height: 20,
          ),
          BlocProvider<WithdrawCubit>.value(
            value: sl<WithdrawCubit>(),
            child: BlocBuilder<WithdrawCubit, WithdrawState>(
              builder: (BuildContext context, WithdrawState state) {
                if (context.read<WithdrawCubit>().bankAccounts.isNotEmpty) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: SizedBox(
                          height: context.height * 0.16,
                          child: const BankMethodSheet(),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    ),
    title: tr('payment_method'),
  );
}
