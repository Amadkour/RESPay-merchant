import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/controller/saving_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/view/component/recent_activity_row.dart';

class RecentActivitySavingPage extends StatelessWidget {
  final SavingCubit cubit;

  const RecentActivitySavingPage({super.key, required this.cubit});

  /// All Activities Page
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarWidget: MainAppBar(title: tr('recent_activity')),
      scaffold: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ...List<Widget>.generate(
                cubit.savingTransactionModels.length,
                (int index) => RecentActivityRow(
                  title: cubit.savingTransactionModels[index].type!,
                  amount: cubit.transactionAmountText(index),
                  date: cubit.savingTransactionModels[index].createdAt!,
                  isGreen: cubit.isGreen(index),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
