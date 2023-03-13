import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/country.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/currency.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/drop_down_list.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/item_in_drop_down.dart';

class CountryAndCurrencyList extends StatelessWidget {
  const CountryAndCurrencyList({super.key, this.showCurrency = true});

  final bool? showCurrency;

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
              child: CustomDropDownListWithValidator(
                  itemIcon: sl<BeneficiaryCubit>().currentCountry?.icon,
                  key: countriesDropdownListKey,
                  itemToString: sl<BeneficiaryCubit>().currentCountry != null
                      ? sl<BeneficiaryCubit>().currentCountry!.name!
                      : "",
                  onChanged: (dynamic p0) =>
                      beneficiaryCubit.setCurrentCountry(p0 as Country),
                  color: AppColors.lightWhite,
                  textValue: sl<BeneficiaryCubit>().currentCountry,
                  list: List<DropdownMenuItem<Country>>.generate(
                      beneficiaryCubit.countries?.length ?? 0, (int index) {
                    final Country item = beneficiaryCubit.countries![index];
                    return DropdownMenuItem<Country>(
                      key: Key("country_withId_${index + 1}"),
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
            if (showCurrency!)
              const SizedBox(
                width: 20,
              ),
            if (showCurrency!)
              Expanded(
                  child: CustomDropDownListWithValidator(
                      key: currenciesDropdownListKey,
                      itemIcon: sl<BeneficiaryCubit>().currentCurrency?.flag,
                      itemToString:
                          sl<BeneficiaryCubit>().currentCurrency != null
                              ? sl<BeneficiaryCubit>().currentCurrency!.name
                              : "",
                      onChanged: (dynamic p0) =>
                          beneficiaryCubit.setCurrentCurrency(p0 as Currency),
                      color: AppColors.lightWhite,
                      textValue: sl<BeneficiaryCubit>().currentCurrency,
                      list: List<DropdownMenuItem<Currency>>.generate(
                          beneficiaryCubit.currencies?.length ?? 0,
                          (int index) {
                        final Currency item =
                            beneficiaryCubit.currencies![index];
                        return DropdownMenuItem<Currency>(
                            key: Key("currency_withId_${index + 1}"),
                            value: item,
                            child: ItemInDropDown(
                              haveImage: true,
                              itemImageUrl: item.flag,
                              itemText: item.name,
                            ));
                      }),
                      isFlagExist: true)),
          ],
        );
      }),
    );
  }
}
