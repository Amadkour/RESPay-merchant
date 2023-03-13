import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/controller/bank_name_controller/bank_name_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/provider/model/bank_name.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/drop_down_list.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/item_in_drop_down.dart';

class DropDownListOfBankNames extends StatelessWidget {
  const DropDownListOfBankNames({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BankNameCubit>.value(
      value: sl<BankNameCubit>()..getBankNames(),
      child: BlocBuilder<BankNameCubit, BankNameState>(
        builder: (BuildContext context, BankNameState state) {
          final BankNameCubit bankNameCubit = sl<BankNameCubit>();
          if (state is BankNamesLoadingState) {
            return const NativeLoading();
          } else {
            return CustomDropDownListWithValidator(
                key: bankNamesDropDownListKey,
                defaultSvgImage: "assets/images/withdraw/bank_icon.svg",
                itemIcon: bankNameCubit.currentBankName?.icon,
                itemToString: bankNameCubit.currentBankName != null
                    ? bankNameCubit.currentBankName!.name!
                    : "",
                onChanged: (dynamic p0) {
                  bankNameCubit.setCurrentBankName(p0 as BankName);
                },
                color: AppColors.lightWhite,
                textValue: bankNameCubit.currentBankName,
                list: bankNameCubit.bankNames!.map((BankName item) {
                  return DropdownMenuItem<BankName>(
                      value: item,
                      child: ItemInDropDown(
                        defaultSvgImage: "assets/images/withdraw/bank_icon.svg",
                        itemText: item.name!,
                        haveImage: true,
                        itemImageUrl: item.icon,
                      ));
                }).toList(),
                isFlagExist: true);
          }
        },
      ),
    );
  }
}
