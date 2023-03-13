import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/controller/budget_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/category_type.dart';
import 'package:res_pay_merchant/features/payment/modules/category/view/component/category_icon_widget.dart';

class BudgetCategoryListSheet extends StatelessWidget {
  const BudgetCategoryListSheet({super.key, required this.onIconChanged});
  final ValueChanged<CategoryTypeModel> onIconChanged;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BudgetCubit>.value(
        value: sl<BudgetCubit>(),
        child: BlocBuilder<BudgetCubit, BudgetState>(
          builder: (BuildContext context, Object? state) {
            final BudgetCubit controller = context.read<BudgetCubit>();
            return Column(
              children: List<Widget>.generate(
                  controller.model.categoryTypes.length, (int index) {
                final CategoryTypeModel category =
                    controller.model.categoryTypes[index];
                return ListTile(
                  key: ValueKey<String>("budget_type_$index"),
                  onTap: () {
                    CustomNavigator.instance.pop();
                    onIconChanged(category);
                  },
                  contentPadding: const EdgeInsets.only(bottom: 15),
                  leading: CategoryIconWidget(
                    icon: category.icon ?? "",
                    slug: category.slug,
                    color: AppColors.greenColor,
                  ),
                  title: Text(
                    category.name,
                    style: paragraphStyle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                  ),
                );
              }),
            );
          },
        ));
  }
}
