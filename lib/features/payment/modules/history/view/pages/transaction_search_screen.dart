import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/history/view/pages/transfer_history_page.dart';
import 'package:res_pay_merchant/features/search/view/page/search_page.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';

class TransactionSearchScreen extends StatefulWidget {
  const TransactionSearchScreen({super.key});

  @override
  State<TransactionSearchScreen> createState() =>
      _TransactionSearchScreenState();
}

class _TransactionSearchScreenState extends State<TransactionSearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TransactionHistoryCubit transactionHistoryCubit =
        sl<TransactionHistoryCubit>();

    return BlocProvider<TransactionHistoryCubit>.value(
      value: transactionHistoryCubit,
      child: SearchPage(
        key: searchTextFieldKey,
        onChanged: (String query) =>
            transactionHistoryCubit.searchInTransactions(query: query),
        onClear: () {
          transactionHistoryCubit.query = "";
          transactionHistoryCubit.getAllTransactions();
        },
        hint: "transaction_search",
        child: BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
          builder: (BuildContext context, TransactionHistoryState state) {
            if (state is TransactionHistoryLoading) {
              return const Center(child: NativeLoading());
            }
            if (state is TransactionHistoryLoaded) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SingleChildScrollView(
                  child: HistoryWithDateGroupingList(
                    data: transactionHistoryCubit.groupedData,
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
