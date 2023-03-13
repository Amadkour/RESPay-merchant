import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/controller/hom_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/history/view/components/transaction_list_widget.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class TransactionsWidget extends StatelessWidget {
  const TransactionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /// I Replace it with transaction history cubit because data already
    /// exist there and there is no need to load it again in home cubit

    return BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
        builder: (BuildContext context, TransactionHistoryState state) {
      final TransactionHistoryCubit controller = sl<TransactionHistoryCubit>();
      return state is HomeLoading
          ? const NativeLoading()
          : Builder(builder: (BuildContext context) {
              return Builder(builder: (BuildContext context) {
                if (controller.transactions.isEmpty) {
                  return const SizedBox.shrink();
                } else {
                  return Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          AutoSizeText(
                            tr('Last Transaction'),
                            style: TextStyle(
                                fontSize: 16,
                                color: AppColors.blackColor,
                                fontFamily: 'Bold',
                                fontWeight: FontWeight.w500),
                          ),
                          InkWell(
                            onTap: () => CustomNavigator.instance
                                .pushNamed(RoutesName.transferHistory),
                            child: Row(
                              children: <Widget>[
                                AutoSizeText(
                                  tr('view_more'),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff2C64E3),
                                      fontFamily: 'Bold',
                                      fontWeight: FontWeight.w500),
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Color(0xff2C64E3),
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      HistoryListWidget(
                        transactions: controller.transactions.take(5).toList(),
                      ),
                    ],
                  );
                }
              });
            });
    });
  }
}
