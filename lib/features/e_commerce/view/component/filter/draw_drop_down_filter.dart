import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/e_commerce/controller/e_commerce_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/filter_item.dart';

class DrawDropDownFilter extends StatelessWidget {
  const DrawDropDownFilter({
    super.key,
    required this.upperIndex,
    required this.filter,
  });

  final FilterItem filter;
  final int upperIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 36,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        width: 120,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.lightGreen.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: DropdownButton<String>(
            alignment: isArabic ? Alignment.centerRight : Alignment.centerLeft,
            key: Key("dropdown_item_at_index_$upperIndex"),
            items: List<DropdownMenuItem<String>>.generate(
                filter.options!.length, (int index) {
              return DropdownMenuItem<String>(
                alignment:
                    isArabic ? Alignment.centerRight : Alignment.centerLeft,
                value: tr(filter.options![index]),
                key: Key(
                    "${filter.options![index].replaceAll(" ", "").toLowerCase()}_at_index_$upperIndex"),
                child: FittedBox(
                  child: AutoSizeText(tr(filter.options![index]),
                      minFontSize: 14,
                      style: TextStyle(
                          color: AppColors.lightGreen,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600),
                      maxLines: 1),
                ),
              );
            }),
            onChanged: (String? value) {
              filter.currentValue = value;
              sl<ECommerceCubit>()
                  .setCurrentValueToFilterOption(filter, currentValue: value);
            },
            value: tr(filter.currentValue!),
            isExpanded: true,
            underline: const SizedBox(),
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.lightGreen,
            )));
  }
}
