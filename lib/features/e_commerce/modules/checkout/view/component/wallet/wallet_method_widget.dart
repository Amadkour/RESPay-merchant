import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/custom_radio.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/view/component/checkout_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';

import 'package:res_pay_merchant/routes/routes_name.dart';

class WalletMethodWidget extends StatelessWidget {
  const WalletMethodWidget({super.key, required this.totalCart});

  final double totalCart;

  @override
  Widget build(BuildContext context) {
    return CheckoutWidget(
      blackTextTitle: tr('pay_by_wallet'),
      imageUrl: 'assets/icons/e_commerce/new_card.svg',
      imageWidth: context.width * 0.06,
      imageHeight: context.width * 0.06,
      showBlueText: sl<TransactionHistoryCubit>().wallet!.total! < totalCart,
      onTapBlueText: () {
        CustomNavigator.instance.pushNamed(RoutesName.newDeposit);
      },
      blueTextTitle: tr('add_balance'),
      radioWidget: CustomRadio<String>(
        value: '',
        onChanged: (String? value) {},
        groupValue: '',
      ),
      title: AutoSizeText(
        'RES Pay Wallet ( ${sl<TransactionHistoryCubit>().wallet == null ? "0 SAR" : sl<TransactionHistoryCubit>().wallet!.total} )',
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
      ),
    );
  }
}
