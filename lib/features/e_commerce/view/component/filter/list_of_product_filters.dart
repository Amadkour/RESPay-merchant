import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/e_commerce/controller/e_commerce_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/filter_item.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/filter/product_filter_item.dart';

class ListOfFilters extends StatelessWidget {
  final List<FilterItem> filters;
  const ListOfFilters({super.key, required this.filters});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ECommerceCubit>.value(
      value: sl<ECommerceCubit>(),
      child: BlocBuilder<ECommerceCubit, ECommerceState>(
        builder: (BuildContext context, ECommerceState state) {
          return ListOfFiltersBody(filters: filters);
        },
      ),
    );
  }
}

class ListOfFiltersBody extends StatelessWidget {
  const ListOfFiltersBody({
    super.key,
    required this.filters,
  });

  final List<FilterItem> filters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: SizedBox(
        height: 36,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: filters.length,
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            width: 4,
          ),
          itemBuilder: (BuildContext context, int index) => SingleTap(
              index: index,
              filter: filters[index]),
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
