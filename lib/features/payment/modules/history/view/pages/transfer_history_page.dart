import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/base_bottom_sheet.dart';
import 'package:res_pay_merchant/core/widget/custom_back_button.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/transaction_model.dart';
import 'package:res_pay_merchant/features/payment/modules/history/view/components/filter_button_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/history/view/components/history_period_filter_sheet_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/history/view/components/history_transaction_type_filer_sheet.dart';
import 'package:res_pay_merchant/features/payment/modules/history/view/components/transaction_list_widget.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class TransferHistoryPage extends StatefulWidget {
  const TransferHistoryPage({super.key});

  @override
  State<TransferHistoryPage> createState() => _TransferHistoryPageState();
}

class _TransferHistoryPageState extends State<TransferHistoryPage> {
  final TransactionHistoryCubit transactionHistoryController =
      sl<TransactionHistoryCubit>();

  @override
  void initState() {
    super.initState();
    transactionHistoryController.getAllTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionHistoryCubit>.value(
      value: transactionHistoryController..resetValues(),
      child: MainScaffold(
        appBarWidget: AppBar(
          leading: const CustomBackButton(),
          centerTitle: false,
          title: Text(tr("history")),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 20),
              child: UnconstrainedBox(
                child: IconButton(
                  key: historySearchButtonKey,
                  onPressed: () {
                    CustomNavigator.instance
                        .pushNamed(RoutesName.transactionSearch);
                  },
                  icon: MyImage.svgAssets(
                    url: "assets/icons/transfer/searchicon.svg",
                    height: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
        scaffold: Builder(builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      bottom: 12,
                    ),
                    child: Text(
                      tr("transaction"),
                      style: paragraphStyle,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      FilterOptionWidget(
                        key: historyCategoryFilterKey,
                        title: "all_transactions",
                        onPressed: () {
                          showCustomBottomSheet(
                            context: context,
                            isScrollable: true,
                            body: const HistoryTransactionTypeFilterSheet(),
                            onPressed: () {
                              transactionHistoryController.loadTransactions();
                            },
                            title: "select_category",
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                      FilterOptionWidget(
                        key: historyDurationFilterKey,
                        title: "all_period",
                        onPressed: () {
                          showCustomBottomSheet(
                            context: context,
                            body: HistoryPeriodFilterSheetWidget(),
                            onCanceled: () {
                              transactionHistoryController.getAllTransactions();
                            },
                            onPressed: () {
                              transactionHistoryController.filterByPeriod();
                            },
                            title: "select_period",
                          );
                        },
                      ),
                    ],
                  ),
                  BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
                      builder: (BuildContext context,
                          TransactionHistoryState state) {
                    if (state is TransactionHistoryError) {
                      return ErrorWidget(state.failure.message);
                    }
                    if (state is TransactionHistoryLoading) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: NativeLoading(),
                      );
                    }
                    if (transactionHistoryController.groupedData.isEmpty) {
                      return EmptyWidget(
                        message: tr('no_transactions'),
                        height: context.width * 0.5,
                        width: context.width * 0.5,
                      );
                    } else {
                      return HistoryWithDateGroupingList(
                          data: transactionHistoryController.groupedData);
                    }
                  }),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class HistoryWithDateGroupingList extends StatelessWidget {
  const HistoryWithDateGroupingList({super.key, required this.data});
  final Map<String, List<TransactionModel>> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List<Widget>.generate(data.length, (int index) {
        final MapEntry<String, List<TransactionModel>> groupedData =
            data.entries.elementAt(index);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
                bottom: 8,
              ),
              child: Text(
                groupedData.key,
                style: smallStyle.copyWith(
                  color: AppColors.descriptionColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            HistoryListWidget(
              transactions: groupedData.value,
            ),
          ],
        );
      }),
    );
  }
}
