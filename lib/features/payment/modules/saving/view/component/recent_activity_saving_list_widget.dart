import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/row_title_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/controller/saving_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/view/component/recent_activity_row.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class RecentActivitySavingListWidget extends StatelessWidget {
  const RecentActivitySavingListWidget({super.key, required this.cubit});

  final SavingCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        /// ---------------------- Recent Activity, View More Row ---------------- ///
        RowTitleWidget(
          blackText: tr('recent_activity'),
          showBlueText: cubit.savingTransactionModels.isNotEmpty,
          blueText: tr('view_more'),

          /// if the user tap view more it will navigate to a
          /// new screen with all of the activities
          onTapBlueText: cubit.savingTransactionModels.isEmpty
              ? null
              : () {
                  CustomNavigator.instance.pushNamed(
                      RoutesName.recentActivitySaving,
                      arguments: cubit);
                },
        ),
        const SizedBox(
          height: 20,
        ),

        if (cubit.savingTransactionModels.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: <Widget>[
                /// List for Show at most first 3 recent activities
                ...List<Widget>.generate(cubit.recentActivityInBeginningLength,
                    (int index) {
                  return Column(
                    children: <Widget>[
                      RecentActivityRow(
                        title: cubit.savingTransactionModels[index].type!,
                        amount: cubit.transactionAmountText(index),
                        date: cubit.savingTransactionModels[index].createdAt!,
                        isGreen: cubit.isGreen(index),
                      ),
                      if (index != 2)
                        Divider(
                          thickness: 1,
                          color: AppColors.borderColor,
                        )
                    ],
                  );
                }),
              ],
            ),
          ),

        /// --------------------- Empty Widget for recent activity ------------------ ///
        if (cubit.savingTransactionModels.isEmpty)
          EmptyWidget(
            message: tr('no_recent_activity'),
            subMessage: tr('no_recent_activity-received'),
            height: context.height * 0.15,
          )
      ],
    );
  }
}
