import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/dropdown_widget.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/date_text_field.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';

class HistoryPeriodFilterSheetWidget extends StatelessWidget {
  HistoryPeriodFilterSheetWidget({super.key});
  final FocusNode fromDateNode = FocusNode();
  final FocusNode toDateNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionHistoryCubit>.value(
      value: sl<TransactionHistoryCubit>(),
      child: Builder(builder: (BuildContext context) {
        final TransactionHistoryCubit historyController =
            context.read<TransactionHistoryCubit>();
        return Column(
          children: <Widget>[
            BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
              builder: (BuildContext context, TransactionHistoryState state) =>
                  CustomDropdown<String>(
                key: periodDropdownKey,
                items: historyController.periodTypes.values.toList(),
                clearButtonKey: clearPeriodButtonKey,
                hasClearButton: true,
                onClear: () {
                  historyController.setPeriod(null);
                },
                value: historyController.period,
                itemToString: (String period) => period,
                onChanged: (String? v) {
                  historyController.setPeriod(v);
                },
                label: "period",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: DateTextField.filter(
                textFieldKey: selectHistoryPeriodFromButtonKey,
                clearButtonKey: clearFromDateButtonKey,
                dateController: historyController.from,
                dateTitle: tr("beginning_of_period"),
                focusNode: fromDateNode,
                dateHint: 'DD/MM/YYYY',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: DateTextField.filter(
                textFieldKey: selectHistoryPeriodToButtonKey,
                clearButtonKey: clearToDateButtonKey,
                dateController: historyController.to,
                dateTitle: tr("end_of_period"),
                focusNode: toDateNode,
                dateHint: 'DD/MM/YYYY',
              ),
            ),
          ],
        );
      }),
    );
  }
}
