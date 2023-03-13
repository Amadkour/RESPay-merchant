import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/extensions/strings_extension.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/custom_radio.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/controller/checkout_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/view/component/bank_account/bank_account_bottom_sheet.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/view/component/checkout_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/controller/withdraw_cubit.dart';

class BankAccountMethodWidget extends StatelessWidget {
  const BankAccountMethodWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WithdrawCubit>.value(
      value: sl<WithdrawCubit>(),
      child: BlocBuilder<WithdrawCubit, WithdrawState>(
        builder: (BuildContext context, WithdrawState state) {
          return BlocProvider<CheckoutCubit>.value(
            value: sl<CheckoutCubit>(),
            child: BlocBuilder<CheckoutCubit, CheckoutState>(
              builder: (BuildContext context, CheckoutState state) {
                return CheckoutWidget(
                  blackTextTitle: tr('pay_by_your_bank_account'),
                  blueTextTitle: tr('change'),
                  radioWidget: CustomRadio<String>(
                    value: 'bank',
                    onChanged: (String? value) {},
                    groupValue: '',
                  ),
                  showContent:
                      context.watch<WithdrawCubit>().bankAccounts.isNotEmpty,
                  onTapBlueText: () {
                    showBankAccountMethodBottomSheet(context: context);
                  },
                  imageUrl: 'assets/images/withdraw/bank_icon.svg',
                  imageHeight: context.width * 0.1,
                  imageWidth: context.width * 0.1,
                  title: AutoSizeText(
                    context.watch<WithdrawCubit>().bankAccounts.isNotEmpty
                        ? capitalize(context
                            .watch<WithdrawCubit>()
                            .bankAccounts[context
                                .watch<CheckoutCubit>()
                                .selectedBankAccountCheckout]
                            .bankName!)
                        : "",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
                  ),

                  /// Cart number
                  subTitle: Row(
                    children: <Widget>[
                      ...List<Widget>.generate(
                          12,
                          (int index) => Row(
                                children: <Widget>[
                                  Container(
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                        color: AppColors.blackColor,
                                        shape: BoxShape.circle),
                                  ),
                                  Builder(builder: (_) {
                                    if ((index + 1) % 4 == 0) {
                                      return const SizedBox(
                                        width: 12,
                                      );
                                    } else {
                                      return const SizedBox(
                                        width: 4,
                                      );
                                    }
                                  }),
                                ],
                              )),
                      AutoSizeText(
                        context.watch<WithdrawCubit>().bankAccounts.isNotEmpty
                            ? context
                                .watch<WithdrawCubit>()
                                .bankAccounts[context
                                    .watch<CheckoutCubit>()
                                    .selectedBankAccountCheckout]
                                .accountNumber!
                                .substring(12, 16)
                            : '',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: AppColors.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
