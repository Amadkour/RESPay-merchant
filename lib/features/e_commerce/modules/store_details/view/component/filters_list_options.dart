import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/e_commerce/controller/e_commerce_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/filter/product_filter_item.dart';

class FiltersListOptions extends StatelessWidget {
  const FiltersListOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ECommerceCubit>.value(
      value: sl<ECommerceCubit>(),
      child: BlocBuilder<ECommerceCubit,ECommerceState>(
        builder: (BuildContext context, ECommerceState state) {
          return SizedBox(
            height: 40,
            child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 1);
                },
                itemBuilder: (BuildContext context, int index) {
                  return SingleTap(index: index,filter: sl<ECommerceCubit>().celebrityFilters[index]);
                },
                itemCount: sl<ECommerceCubit>().celebrityFilters.length,
                scrollDirection:
                Axis.horizontal
            ),
          );
        },
      ),
    );
  }
}
