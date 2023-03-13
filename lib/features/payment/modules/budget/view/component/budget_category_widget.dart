import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/controller/budget_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/budget_category_model.dart';
import 'package:res_pay_merchant/features/payment/modules/category/view/component/category_icon_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/container_with_shadow_widget.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class BudgetCategoryWidget extends StatelessWidget {
  const BudgetCategoryWidget(
      {super.key, this.isFullSize = false, required this.budgetCategoryModel});

  final bool isFullSize;
  final BudgetCategoryModel budgetCategoryModel;

  @override
  Widget build(BuildContext context) {
    final BudgetCubit budgetController = sl<BudgetCubit>();

    return BlocConsumer<BudgetCubit, BudgetState>(
        listener: (BuildContext context, BudgetState state) {
      if (state is BudgetError) {
        MyToast(state.failure.message);
      }
    }, builder: (BuildContext context, BudgetState state) {
      final BudgetCategoryModel? category = budgetController.model.categories
          .whereOrNull((BudgetCategoryModel element) =>
              element.uuid == budgetCategoryModel.uuid);
      if (category != null) {
        if (isFullSize) {
          return _FullSizeCategoryWidget(
            category: category,
            loading: state is BudgetCategoryLoading &&
                state.uuid == budgetCategoryModel.uuid,
          );
        } else {
          return _SmallCategoryWidget(
            category: budgetCategoryModel,
            loading: state is BudgetCategoryLoading &&
                state.uuid == budgetCategoryModel.uuid,
          );
        }
      } else {
        return const SizedBox();
      }
    });
  }
}

class _FullSizeCategoryWidget extends StatelessWidget {
  const _FullSizeCategoryWidget({
    required this.category,
    this.loading = false,
  });

  final BudgetCategoryModel category;

  final bool loading;
  @override
  Widget build(BuildContext context) {
    return ContainerWithShadow(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CategoryIconWidget(
                color: AppColors.greenColor,
                icon: category.icon,
                slug: category.slug,
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        category.name,
                        style: paragraphStyle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text.rich(TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: "${category.amount}",
                          style: header5Style.copyWith(fontSize: 18),
                        ),
                        TextSpan(
                          text: " ${tr('sar')}",
                          style: header5Style.copyWith(
                            fontSize: 14,
                          ),
                        )
                      ])),
                    ],
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tr("used"),
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.darkGrayColor,
                      ),
                    ),
                    Text(
                      "${category.amount} ${tr('sar')}",
                      style: smallStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tr("remaining"),
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.darkGrayColor,
                      ),
                    ),
                    Text(
                      "${category.amount} ${tr('sar')}",
                      style: smallStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 11,
              bottom: 5,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(110),
              child: LinearProgressIndicator(
                value: category.percentage,
                backgroundColor: AppColors.borderColor,
                color: AppColors.greenColor,
                minHeight: 10,
              ),
            ),
          ),
          Align(
            alignment: (AlignmentGeometry.lerp(
              AlignmentDirectional.topStart,
              AlignmentDirectional.topEnd,
              !isArabic ? (category.percentage) - 0.09 : (category.percentage),
            ))!,
            child: Stack(
              children: <Widget>[
                MyImage.assets(
                  url: "assets/icons/budget/percentage.png",
                  width: 30,
                  height: 18,
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      "${(category.percentage).toInt()} %",
                      style: smallStyle.copyWith(
                        fontSize: 7,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          if (category.isActive != null)
            _CategorySwitchWidget(
              loading: loading,
              category: category,
            )
        ],
      ),
    );
  }
}

class _CategorySwitchWidget extends StatelessWidget {
  const _CategorySwitchWidget({
    required this.loading,
    required this.category,
  });

  final bool loading;
  final BudgetCategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          tr("send_notification_when"),
          style: smallStyle.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
        ),
        if (loading)
          NativeLoading2()
        else
          Switch(
            key: toggleBudgetSwitchKey,
            value: category.isActive!,
            activeColor: AppColors.greenColor,
            onChanged: (bool v) async {
              await sl<BudgetCubit>().toggleCategory(category.uuid);
            },
          )
      ],
    );
  }
}

class _SmallCategoryWidget extends StatelessWidget {
  const _SmallCategoryWidget({
    required this.category,
    this.loading = false,
  });

  final BudgetCategoryModel category;

  final bool loading;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          CustomNavigator.instance.pushNamed(
            RoutesName.budgetCategoryPage,
            arguments: category,
          );
        },
        child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CategoryIconWidget(
                      color: AppColors.greenColor,
                      icon: category.icon,
                      slug: category.slug,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                category.name,
                                style: smallStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "${category.used} ${tr('sar')}",
                                style: smallStyle.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 11,
                              bottom: 5,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(110),
                              child: LinearProgressIndicator(
                                value: category.percentage,
                                backgroundColor: AppColors.borderColor,
                                color: AppColors.greenColor,
                                minHeight: 10,
                              ),
                            ),
                          ),
                          Align(
                            alignment: (AlignmentGeometry.lerp(
                              AlignmentDirectional.topStart,
                              AlignmentDirectional.topEnd,
                              !isArabic
                                  ? (category.percentage) - 0.09
                                  : (category.percentage),
                            ))!,
                            child: Stack(
                              children: <Widget>[
                                MyImage.assets(
                                  url: "assets/icons/budget/percentage.png",
                                  width: 30,
                                  height: 18,
                                ),
                                Positioned.fill(
                                  child: Center(
                                    child: Text(
                                      "${(category.percentage).toInt()} %",
                                      style: smallStyle.copyWith(
                                        fontSize: 7,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(
                              "${category.amount} ${tr('sar')}",
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                if (category.isActive != null)
                  _CategorySwitchWidget(
                    loading: loading,
                    category: category,
                  )
              ],
            )));
  }
}
