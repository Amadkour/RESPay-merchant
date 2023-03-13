import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_options/transfer_options_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/drop_down_list.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/item_in_drop_down.dart';

class DropDownListOfWalletNames extends StatelessWidget {
  const DropDownListOfWalletNames({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BeneficiaryCubit>.value(
      value: sl<BeneficiaryCubit>(),
      child: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
        builder: (BuildContext context, BeneficiaryState state) =>
            CustomDropDownListWithValidator(
                defaultSvgImage: "assets/images/transfer/walletlogo.svg",
                isFlagExist: true,
                key: walletNamesDropDownListKey,
                itemToString: sl<BeneficiaryCubit>().currentWalletName ?? "",
                onChanged: (dynamic p0) =>
                    sl<BeneficiaryCubit>().setCurrentWalletName(p0 as String),
                color: AppColors.lightWhite,
                textValue: sl<BeneficiaryCubit>().currentWalletName,
                list:
                    sl<TransferOptionsCubit>().walletNames!.map((String item) {
                  return DropdownMenuItem<String>(
                      value: item,
                      key: Key(item.toLowerCase().replaceAll(" ", "_")),
                      child: ItemInDropDown(
                          haveImage: true,
                          defaultSvgImage:
                              "assets/images/transfer/walletlogo.svg",
                          itemText: item));
                }).toList()),
      ),
    );
  }
}
