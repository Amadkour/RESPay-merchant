import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/base_bottom_sheet.dart';
import 'package:res_pay_merchant/core/widget/button/clickable_container.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/amount/view/components/transfer_amount_textfield.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/controller/budget_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/category_type.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/view/component/budget_category_list_sheet.dart';
import 'package:res_pay_merchant/features/payment/modules/category/view/component/category_icon_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_options/transfer_options_cubit.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class NewBudgetCategoryPage extends StatelessWidget {
  const NewBudgetCategoryPage({super.key, this.isEditing = false});

  final bool isEditing;

  @override
  Widget build(BuildContext context) {
    final BudgetCubit budgetCubit = sl<BudgetCubit>();
    return MainScaffold(
      appBarWidget: const MainAppBar(
        title: "add_new_category",
      ),
      scaffold: BlocProvider<BudgetCubit>.value(
        value: budgetCubit,
        child: Scaffold(
          body: NewBudgetCategoryScaffold(
            budgetCubit: budgetCubit,
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: BlocBuilder<BudgetCubit, BudgetState>(
                builder: (BuildContext context, BudgetState state) =>
                    LoadingButtonBudgetWidget(
                      budgetCubit: budgetCubit,
                      isEditing: isEditing,
                      onActionSuccess: _onActionSuccess,
                    )),
          ),
        ),
      ),
    );
  }

  ///this function responsible to show toast
  ///and back to categories page
  /// remove deleted category from transfer options cubit
  void _onActionSuccess(BudgetCubit budgetCubit, bool editing) {
    sl<TransferOptionsCubit>().categoriesModel = budgetCubit.model.categories;

    MyToast(
      editing ? tr('category_updated') : tr('category_added'),
      background: AppColors.greenColor,
    );
    if (!editing) {
      CustomNavigator.instance.pop();
    } else {
      CustomNavigator.instance.popUntil(
          (Route<dynamic> route) => route.settings.name == RoutesName.budget);
    }
  }
}

class NewBudgetCategoryScaffold extends StatelessWidget {
  const NewBudgetCategoryScaffold({super.key, required this.budgetCubit});

  final BudgetCubit budgetCubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 62, vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TransactionAmountTextField(
              key: amountTextFieldKey,
              autoFocus: true,
              controller: budgetCubit.amountController,
              label:
                  "${DateFormat('MMMM').format(DateTime.now())} ${tr("amount")}",
              textAlign: TextAlign.center,
              withCurrency: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocBuilder<BudgetCubit, BudgetState>(
              buildWhen: (BudgetState previous, BudgetState current) {
                return current is BudgetSelectCategory;
              },
              builder: (BuildContext context, Object? state) {
                final CategoryTypeModel? category = budgetCubit.category;
                return ClickableContainer(
                  key: openCategoriesSheetButtonKey,
                  onPressed: () {
                    showCustomBottomSheet(
                      isScrollable: true,
                      context: context,
                      body: BudgetCategoryListSheet(
                        onIconChanged: (CategoryTypeModel v) {
                          budgetCubit.changeCategory(v);
                        },
                      ),
                      title: "budget_category",
                    );
                  },

                  leading: category != null
                      ? CategoryIconWidget(
                          color: AppColors.greenColor,
                          icon: category.icon ?? "",
                          slug: category.slug,
                        )
                      : null,
                  title: 'category_type',
                  value: category == null ? tr("select_type") : category.name,
                  color: Colors.white,
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class LoadingButtonBudgetWidget extends StatelessWidget {
  const LoadingButtonBudgetWidget(
      {super.key,
      required this.budgetCubit,
      required this.isEditing,
      required this.onActionSuccess});

  final BudgetCubit budgetCubit;
  final bool isEditing;
  final void Function(BudgetCubit budgetCubit, bool editing) onActionSuccess;

  @override
  Widget build(BuildContext context) {
    return LoadingButton(
        key: createBudgetCategoryKey,
        isLoading: budgetCubit.state is BudgetLoading,
        title: tr(isEditing ? 'edit_budget' : 'add_budget'),
        enable: budgetCubit.enableButton,
        onTap: () async {
          if (isEditing) {
            final bool result = await budgetCubit.updateCategory();
            if (result) {
              onActionSuccess(budgetCubit, isEditing);
            }
          } else {
            final bool result = await budgetCubit.addCategory();
            if (result) {
              onActionSuccess(budgetCubit, isEditing);
            }
          }
        });
  }
}
