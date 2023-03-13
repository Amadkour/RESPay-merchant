import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/drop_down_list.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/item_in_drop_down.dart';

class DropListOfRelationShips extends StatelessWidget {
  const DropListOfRelationShips({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BeneficiaryCubit>.value(
      value: sl<BeneficiaryCubit>(),
      child: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
        builder: (BuildContext context, BeneficiaryState state) {
          final BeneficiaryCubit beneficiaryCubit =
              context.read<BeneficiaryCubit>();
          return CustomDropDownListWithValidator(
              key: relationShipsDropdownListKey,
              itemToString: sl<BeneficiaryCubit>().currentRelationShip ?? "",
              onChanged: (dynamic p0) =>
                  beneficiaryCubit.setCurrentRelationShip(p0 as String),
              color: AppColors.lightWhite,
              textValue: sl<BeneficiaryCubit>().currentRelationShip,
              list: sl<BeneficiaryCubit>().relationships.map((String item) {
                return DropdownMenuItem<String>(
                    key: Key(item.toLowerCase()),
                    value: item,
                    child: ItemInDropDown(
                      itemText: item,
                    ));
              }).toList());
        },
      ),
    );
  }
}
