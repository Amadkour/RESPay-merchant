import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/country.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/name_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/swift_code_text_feild.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/drop_down_list.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/item_in_drop_down.dart';

class SwiftCodeWithNationalityRow extends StatelessWidget {
  const SwiftCodeWithNationalityRow({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BeneficiaryCubit>.value(
      value: sl<BeneficiaryCubit>(),
      child: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
        builder: (BuildContext context, BeneficiaryState state) {
          final BeneficiaryCubit beneficiaryCubit = sl<BeneficiaryCubit>();
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SwiftCodeTextField(
                  minErrorMessage: "at least 8",
                  minLength: 8,
                  focusNode: beneficiaryCubit.swiftCodeFocusNode,
                  onChanged: (String value) {
                    sl<BeneficiaryCubit>().swiftCode = value;
                  },
                  errorMessage: context.watch<BeneficiaryCubit>().swiftCodeError,
                  key: swiftCodeTextFieldKey,
                  hint: "Swift Code",
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: CustomDropDownListWithValidator(
                    key: nationalityDropDownListKey,
                    itemIcon: sl<BeneficiaryCubit>().currentNationality?.icon,
                    itemToString:
                        sl<BeneficiaryCubit>().currentNationality != null
                            ? sl<BeneficiaryCubit>().currentNationality?.name!
                            : "",
                    onChanged: (dynamic p0) =>
                        beneficiaryCubit.setCurrentNationality(p0 as Country),
                    color: AppColors.lightWhite,
                    textValue: sl<BeneficiaryCubit>().currentNationality,
                    list: List<DropdownMenuItem<Country>>.generate(
                        beneficiaryCubit.countries?.length ?? 0, (int index) {
                      final Country item = beneficiaryCubit.countries![index];
                      return DropdownMenuItem<Country>(
                        key: Key("nationality_withId_${index + 1}"),
                        value: item,
                        child: ItemInDropDown(
                          haveImage: true,
                          itemImageUrl: item.icon,
                          itemText: item.name!,
                        ),
                      );
                    }),
                    isFlagExist: true),
              ),
            ],
          );
        },
      ),
    );
  }
}
