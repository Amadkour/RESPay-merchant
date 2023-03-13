import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/chart/chart_container_widget.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/controller/budget_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/view/component/budget_category_widget.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BudgetCubit budgetCubit = sl<BudgetCubit>();
    return MainScaffold(
      appBarWidget: MainAppBar(
        title: tr('budget'),
      ),
      scaffold: BlocProvider<BudgetCubit>.value(
        value: budgetCubit,
        child: Builder(builder: (BuildContext context) {
          final BudgetCubit budgetCubit = context.read<BudgetCubit>();
          return BlocListener<BudgetCubit, BudgetState>(
            listener: (BuildContext context, BudgetState state) {
              if (state is BudgetError) {
                MyToast(state.failure.message);
              }
            },
            child: Scaffold(
              body: BudgetPageScaffold(budgetCubit: budgetCubit),
            ),
          );
        }),
      ),
    );
  }
}

class BudgetPageScaffold extends StatelessWidget {
  const BudgetPageScaffold({super.key, required this.budgetCubit});

  final BudgetCubit budgetCubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: budgetScrollView,
      child: Column(
        children: <Widget>[
          BlocBuilder<BudgetCubit, BudgetState>(
            builder: (BuildContext context, BudgetState? state) {
              if (state is BudgetLoading) {
                return const NativeLoading();
              }

              return ChartContainerWidget(
                total: budgetCubit.model.total,
                data: budgetCubit.model.analytics,
                type: 'budget',
                duration: budgetCubit.duration,
                onDurationChanged: budgetCubit.model.analytics.isEmpty
                    ? null
                    : budgetCubit.changeDuration,
              );
            },
          ),

          //-------categories widget---//

          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 24,
              bottom: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  tr("category"),
                  style: paragraphStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  key: addNewBudgetButtonKey,
                  onPressed: () {
                    budgetCubit.resetData();

                    CustomNavigator.instance.pushNamed(
                      RoutesName.addBudgetCategory,
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        tr('add_new'),
                        style: TextStyle(
                          color: AppColors.blueColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.add,
                        color: AppColors.blueColor,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: BlocBuilder<BudgetCubit, BudgetState>(
              builder: (BuildContext context, Object? state) {
                if (state is BudgetLoading) {
                  return const NativeLoading();
                }
                if (budgetCubit.model.categories.isEmpty) {
                  return EmptyWidget(
                    message: tr("no_data_to_display"),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: List<Widget>.generate(
                          budgetCubit.model.categories.length, (int index) {
                        return BudgetCategoryWidget(
                          key: ValueKey<String>(
                              budgetCubit.model.categories[index].name),
                          budgetCategoryModel:
                              budgetCubit.model.categories[index],
                        );
                      }),
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
