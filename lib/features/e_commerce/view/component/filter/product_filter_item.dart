import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/e_commerce/controller/e_commerce_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/filter_item.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/filter/draw_drop_down_filter.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/transfer_to/build_tab_item.dart';

class SingleTap extends StatelessWidget {
  const SingleTap({super.key, required this.filter, required this.index});
  final FilterItem filter;
  final int index;
  @override
  Widget build(BuildContext context) {
    return filter.options!.length > 1
        ? DrawDropDownFilter(
            filter: filter,
            upperIndex: index,
          )
        : InkWell(
            onTap: () {
              sl<ECommerceCubit>().setCurrentValueToFilterOption(filter,
                  currentValue: tr(filter.options!.first));
              // print(filter.currentValue);
            },
            child: BuildTabItem(
                label: filter.options!.first,
                isThisCurrentIndex:
                    sl<ECommerceCubit>().currentFilterItem.currentValue ==
                        tr(filter.options!.first)),
          );
  }
}
