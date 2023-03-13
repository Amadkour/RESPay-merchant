import 'package:flutter/material.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/transaction_model.dart';
import 'package:res_pay_merchant/features/payment/modules/history/view/components/transaction_history_item_widget.dart';

class HistoryListWidget extends StatelessWidget {
  const HistoryListWidget({
    super.key,
    required this.transactions,
  });

  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        children: List<Widget>.generate(transactions.length, (int i) {
          final TransactionModel transaction = transactions[i];
          return TransactionHistoryItemWidget(
            transaction: transaction,
            isLast: i == transactions.length - 1,
          );
        }),
      ),
    );
  }
}
