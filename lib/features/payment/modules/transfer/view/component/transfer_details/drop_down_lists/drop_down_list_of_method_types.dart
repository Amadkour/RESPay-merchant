import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_options/transfer_options_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/drop_down_list.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/item_in_drop_down.dart';

class DropDownListOfMethodTypes extends StatelessWidget {
  const DropDownListOfMethodTypes({super.key});
  @override
  Widget build(BuildContext context) {
    final TransferOptionsCubit transCubit = sl<TransferOptionsCubit>();
    final String currentType =
        sl<BeneficiaryCubit>().currentTransferTypeTapIndex == 1
            ? "external"
            : "internal";
    final List<String> currentList =
        sl<BeneficiaryCubit>().currentTransferTypeTapIndex == 1
            ? transCubit.localTransferTypes!
            : transCubit.internationalTransferTypes!;
    return CustomDropDownListWithValidator(
        itemToString:
            currentList.contains(transCubit.currentMethodType.methodTypeName)
                ? transCubit.currentMethodType.methodTypeName
                : currentList.first,
        onChanged: (dynamic value) {
          sl<BeneficiaryCubit>().configurationWhenTransferMethodChanged(
              value as String,
              sl<BeneficiaryCubit>().currentTransferTypeTapIndex);
          sl<TransferOptionsCubit>().setCurrentMethodType(value);
        },
        color: AppColors.lightWhite,
        textValue:
            currentList.contains(transCubit.currentMethodType.methodTypeName)
                ? transCubit.currentMethodType.methodTypeName
                : currentList.first,
        list: currentList.map((String item) {
          return DropdownMenuItem<String>(
              key: Key(
                  "${transCubit.currentMethodType.methodTypeName.toLowerCase().replaceAll(" ", "")}_$currentType"),
              value: item,
              child: ItemInDropDown(
                itemText: item,
              ));
        }).toList());
  }
}
