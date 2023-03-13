import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/extensions/strings_extension.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transaction_types/controller/transaction_type_dart_cubit.dart';

class HistoryTransactionTypeFilterSheet extends StatelessWidget {
  const HistoryTransactionTypeFilterSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<TransactionTypeCubit>.value(
          value: sl<TransactionTypeCubit>(),
        ),
        BlocProvider<TransactionHistoryCubit>.value(
          value: sl<TransactionHistoryCubit>(),
        ),
      ],
      child: BlocBuilder<TransactionHistoryCubit, TransactionHistoryState>(
          bloc: sl<TransactionHistoryCubit>(),
          builder: (BuildContext context, TransactionHistoryState state) {
            final TransactionHistoryCubit historyCubit =
                context.read<TransactionHistoryCubit>();
            final List<String> types = historyCubit.transactionTypes;
            return Column(
              children: <Widget>[
                    ListTile(
                      contentPadding: const EdgeInsets.only(bottom: 10),
                      leading: const _TypeIconWidget(
                        icon: "assets/icons/history/all_categories.svg",
                      ),
                      title: Text(
                        tr("all_category"),
                        style: paragraphStyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: Radio<String?>(
                        value: null,
                        groupValue: historyCubit.filterCategory,
                        onChanged: (String? v) {
                          CustomNavigator.instance.pop();
                          historyCubit.getAllTransactions();
                        },
                      ),
                    )
                  ] +
                  List<Widget>.generate(types.length, (int index) {
                    final String type = types[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.only(bottom: 10),
                      leading: _TypeIconWidget(
                        icon:
                            "assets/icons/transaction_types/${type.toLowerCase()}.svg",
                      ),
                      title: Text(
                        type.capitalize(),
                        style: paragraphStyle.copyWith(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      trailing: Radio<String?>(
                        key: ValueKey<int>(index),
                        value: type,
                        groupValue: historyCubit.filterCategory,
                        onChanged: (String? v) {
                          CustomNavigator.instance.pop();
                          historyCubit
                            ..setCategory(type)
                            ..filterByCategory();
                        },
                      ),
                    );
                  }),
            );
          }),
    );
  }
}

class _TypeIconWidget extends StatelessWidget {
  const _TypeIconWidget({
    required this.icon,
  });

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Color(0xffF1F3F6)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: MyImage.svgAssets(
          url: icon,
          height: 24,
          width: 24,
        ),
      ),
    );
  }
}
