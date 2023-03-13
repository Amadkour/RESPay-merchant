import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/controller/budget_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/budget_category_model.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/view/component/budget_category_widget.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class BudgetCategoryDetailsPage extends StatelessWidget {
  const BudgetCategoryDetailsPage({super.key, required this.category});
  final BudgetCategoryModel category;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BudgetCubit>.value(
      value: sl<BudgetCubit>(),
      child: Builder(builder: (BuildContext context) {
        final BudgetCubit budgetController = context.read<BudgetCubit>();

        return MainScaffold(
            appBarWidget: MainAppBar(
              title: tr('budget details'),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  LoadingButton(
                    key: editBudgetCategoryButtonKey,
                    isLoading: false,
                    title: tr('edit'),
                    onTap: () {
                      budgetController.initCategoryForEdit(category);
                      CustomNavigator.instance.pushNamed(
                        RoutesName.addBudgetCategory,
                        arguments: true,
                      );
                    },
                  ),
                  BlocBuilder<BudgetCubit, BudgetState>(
                    builder: (BuildContext context, BudgetState state) =>
                        LoadingButton(
                      key: deleteBudgetButtonKey,
                      topPadding: 0,
                      isLoading: state is BudgetLoading,
                      title: tr('delete'),
                      onTap: () async {
                        await deleteCategory(budgetController);
                      },
                      backgroundColor: AppColors.backgroundColor,
                      fontColor: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            scaffold: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                        bottom: 20,
                      ),
                      child: BudgetCategoryWidget(
                        budgetCategoryModel: category,
                        isFullSize: true,
                      ),
                    ),
                  ],
                ),
              ),
            ));
      }),
    );
  }

  /// This Function deletes budget category

  Future<void> deleteCategory(BudgetCubit budgetController) async {
    final bool result = await budgetController.delete(category.uuid);
    if (result) {
      CustomNavigator.instance.pop();
      MyToast.success(tr('category_deleted'));
    }
  }
}
