import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/features/payment/modules/category/controller/cubit/category_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/category/provider/model/category_model.dart';
import 'package:res_pay_merchant/features/payment/modules/category/view/component/category_icon_widget.dart';

class CategoryListSheet extends StatelessWidget {
  const CategoryListSheet({super.key, required this.onIconChanged});
  final ValueChanged<CategoryModel> onIconChanged;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryCubit>.value(
        value: sl<CategoryCubit>(),
        child: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (BuildContext context, Object? state) {
            final CategoryCubit categoryBloc = context.watch<CategoryCubit>();
            return Column(
              children: categoryBloc.categories.map((CategoryModel e) {
                return ListTile(
                  onTap: () {
                    CustomNavigator.instance.pop();
                    onIconChanged(e);
                  },
                  contentPadding: const EdgeInsets.only(bottom: 15),
                  leading: CategoryIconWidget(
                    color: e.color,
                    icon: e.icon,
                  ),
                  title: Text(
                    e.name,
                    style: paragraphStyle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.black,
                  ),
                );
              }).toList(),
            );
          },
        ));
  }
}
