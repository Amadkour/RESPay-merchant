import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/controller/shipping_location_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/model/city_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/item_in_drop_down.dart';

import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/shared/drop_down_list.dart';

class CityDropDownWidget extends StatelessWidget {
  const CityDropDownWidget(
      {super.key, required this.shippingState, required this.cubit});

  final ShippingLocationState shippingState;
  final ShippingLocationCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomDropDownListWithValidator(
      key: citiesDropdownListKey,
      color: AppColors.blackColor,
      isLoading: shippingState is ShippingLocationCitiesLoading,
      onChanged: (dynamic value) async {
        cubit.changeCity(cityModel: value as CityModel);
      },
      itemToString:cubit.currentCity != null ? cubit.currentCity!.name! : "",
      textValue: cubit.currentCity,
      // list: beneficiaryCubit.countries!.map((Country item) {

      // }).toList(),
      hintText: tr("select_city"),
      list: List<DropdownMenuItem<CityModel>>.generate(cubit.cities.length, (int index) {
        return DropdownMenuItem<CityModel>(
            key: cubit.cities[index].uuid == cubit.cities[0].uuid ? firstCityKey : null,
            value: cubit.cities[index],
            child: ItemInDropDown(
              itemText: cubit.cities[index].name!,
            ));
      }),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: <Widget>[
  //       AutoSizeText(tr('city')),
  //       CustomDropDownListWithValidator(
  //         key: citiesDropdownListKey,
  //         color: AppColors.blackColor,
  //         isLoading: shippingState is ShippingLocationCitiesLoading,
  //         itemToString:
  //             cubit.currentCity == null ? "" : cubit.currentCity!.name!,
  //         list: cubit.cities
  //             .map(
  //               (CityModel e) => DropdownMenuItem<CityModel>(
  //                   key: e.uuid == cubit.cities[0].uuid ? firstCityKey : null,
  //                   value: e,
  //                   child: ItemInDropDown(
  //                     itemText: e.name!,
  //                   )),
  //             )
  //             .toList(),
  //         onChanged: (dynamic value) {
  //           cubit.changeCity(cityModel: value as CityModel);
  //         },
  //         textValue: cubit.currentCity,
  //       ),
  //     ],
  //   );
  // }
}
