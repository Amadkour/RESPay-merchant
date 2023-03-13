import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/settings_list.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/tab_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/view/component/transaction_history_list.dart';

class OtherFeaturesWidget extends StatelessWidget {
  final CardsCubit cubit;

  const OtherFeaturesWidget({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AutoSizeText(
          tr('other_feature'),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        SizedBox(
          height: context.height * 0.01,
        ),
        Row(
          children: <Widget>[
            TabWidget(
              cubit: cubit,
              index: 0,
              tabTitle: tr('settings'),
            ),
            const SizedBox(
              width: 15,
            ),
            TabWidget(
              cubit: cubit,
              index: 1,
              tabTitle: tr('transaction_history'),
            ),
          ],
        ),
        SizedBox(
          height: context.height * 0.03,
        ),
        if (cubit.tapBarIndex == 0)
          SettingsList(
            cubit: cubit,
          ),
        if (cubit.tapBarIndex == 1) TransactionHistoryList(cubit)
      ],
    );
  }
}
