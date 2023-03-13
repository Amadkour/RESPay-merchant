import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/address_bottom_sheet.dart';
import 'package:res_pay_merchant/core/widget/dotted_container.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/controller/shipping_location_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/checkout/view/component/checkout_widget.dart';

class DeliveryLocationWidget extends StatelessWidget {
  const DeliveryLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ShippingLocationCubit cubit = context.watch<ShippingLocationCubit>();
    return CheckoutWidget(
      blackTextTitle: tr('delivery_locations'),
      showContent: cubit.addresses.isNotEmpty,
      addressTitle: cubit.addresses.isEmpty
          ? ''
          : '${cubit.addresses[cubit.selectedAddressIndex].streetName}, '
              'apartment: ${cubit.addresses[cubit.selectedAddressIndex].apartment}, '
              'state: ${cubit.addresses[cubit.selectedAddressIndex].state}, '
              'postal code: ${cubit.addresses[cubit.selectedAddressIndex].zipCode}',
      imageUrl: 'assets/images/profile/address.svg',
      blueTextTitle:
          cubit.addresses.isNotEmpty ? tr('change') : tr('add_address'),
      showBlueText: cubit.addresses.isNotEmpty,
      onTapBlueText: () {
        showAddressBottomSheet(context: context, buttonTitle: tr('continue'));
      },
      emptyWidget: Container(
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: InkWell(
              key: addNewAddressWhenNoAddressesFoundKey,
              onTap: () {
                showAddressBottomSheet(
                    context: context, buttonTitle: tr('continue'));
              },
              child: const EmptyAddDottedWidget(
                title: 'Add new Address',
              ))),
    );
  }
}
