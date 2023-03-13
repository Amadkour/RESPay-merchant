import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/controller/shipping_location_cubit.dart';

class DefaultAddressCheckboxWidget extends StatelessWidget {
  const DefaultAddressCheckboxWidget({super.key, required this.cubit});
  final ShippingLocationCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Checkbox(
            key: defaultAddressCheckBoxKey,
            value: cubit.isDefaultAddressCheckBoxValue,
            fillColor: MaterialStateProperty.all(AppColors.blackColor),
            onChanged: (bool? value) {
              cubit.changeDefaultAddress(value: value!);
            }),
        AutoSizeText(
          tr('mark_default_address'),
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ],
    );
  }
}
