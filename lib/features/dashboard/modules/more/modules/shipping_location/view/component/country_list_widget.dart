import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/country.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/controller/shipping_location_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/drop_down_list.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/item_in_drop_down.dart';

class CountryListWidget extends StatelessWidget {
  const CountryListWidget({super.key, this.showCurrency = true, required this.shippingLocationCubit});

  final bool? showCurrency;
  final ShippingLocationCubit shippingLocationCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BeneficiaryCubit>.value(
      value: sl<BeneficiaryCubit>(),
      child: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
        builder: (BuildContext context, BeneficiaryState state) {
          final BeneficiaryCubit beneficiaryCubit = sl<BeneficiaryCubit>();
          return DropDownOdCountriesBody(beneficiaryCubit: beneficiaryCubit, shippingLocationCubit: shippingLocationCubit);
        },
      ),
    );
  }
}

class DropDownOdCountriesBody extends StatelessWidget {
  const DropDownOdCountriesBody({
    super.key,
    required this.beneficiaryCubit,
    required this.shippingLocationCubit,
  });

  final BeneficiaryCubit beneficiaryCubit;
  final ShippingLocationCubit shippingLocationCubit;

  @override
  Widget build(BuildContext context) {
    return CustomDropDownListWithValidator(
      key: countriesDropdownListKey,
      hintText: tr("select_country"),
      itemToString: beneficiaryCubit.currentCountry != null ? beneficiaryCubit.currentCountry!.name! : "",
      onChanged: (dynamic value) async {
        beneficiaryCubit.setCurrentCountry(value as Country);
        await shippingLocationCubit.getCities(beneficiaryCubit.currentCountry!.uuid);
      },
      color: AppColors.backgroundColor,
      textValue: beneficiaryCubit.currentCountry,
      // list: beneficiaryCubit.countries!.map((Country item) {

      // }).toList(),

      list: List<DropdownMenuItem<Country>>.generate(beneficiaryCubit.countries?.length ?? 0, (int index) {
        final Country item = beneficiaryCubit.countries!.elementAt(index);
        return DropdownMenuItem<Country>(
            key: Key("country_withId_${index + 1}"),
            value: item,
            child: ItemInDropDown(
              itemText: item.name!,
            ));
      }),
    );
  }
}
