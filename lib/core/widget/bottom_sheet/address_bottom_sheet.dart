import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';

import 'package:res_pay_merchant/core/services/navigation.dart';

import 'package:res_pay_merchant/core/widget/bottom_sheet/base_bottom_sheet.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/dialogs/confitm_cancel_dialog.dart';
import 'package:res_pay_merchant/core/widget/dotted_container.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/controller/shipping_location_cubit.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

void showAddressBottomSheet({
  required BuildContext context,
  required String buttonTitle,
}) {
  showCustomBottomSheet(
    context: context,
    hasButtons: false,
    title: tr('shipping_location'),
    isTwoButtons: false,
    body: BlocProvider<ShippingLocationCubit>.value(
      value: sl<ShippingLocationCubit>(),
      child: BlocBuilder<ShippingLocationCubit, ShippingLocationState>(
        builder: (BuildContext context, ShippingLocationState state) {
          final ShippingLocationCubit cubit = BlocProvider.of(context);
          if (state is ShippingLocationLoadLocation) {
            return const Center(
              child: NativeLoading(),
            );
          } else {
            return ListOfAddresses(
              cubit: cubit,
              state: state,
              buttonTitle: buttonTitle,
            );
          }
        },
      ),
    ),
  );
}

class ListOfAddresses extends StatelessWidget {
  const ListOfAddresses({
    super.key,
    required this.state,
    required this.cubit,
    required this.buttonTitle,
  });

  final ShippingLocationCubit cubit;
  final ShippingLocationState state;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: selectAddressListKey,
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        ...List<Widget>.generate(
          cubit.addresses.length,
          (int index) => SingleShippingLocationItem(cubit: cubit, index: index),
        ),
        InkWell(
          onTap: () {
            CustomNavigator.instance.pushNamed(RoutesName.shippingLocation);
          },
          child: EmptyAddDottedWidget(
            key: addNewAddressKey,
            title: tr('add_new_address'),
          ),
        ),
        LoadingButton(
          key: continueButtonAfterSelectAddress,
          title: buttonTitle,
          enable: cubit.addresses.isNotEmpty,
          onTap: () async {
            await cubit.updateAddress();
            CustomNavigator.instance.pop();
          },
          isLoading: state is ShippingLocationUpdateAddress,
        ),
      ],
    );
  }
}

class SingleShippingLocationItem extends StatelessWidget {
  const SingleShippingLocationItem({
    super.key,
    required this.index,
    required this.cubit,
  });

  final ShippingLocationCubit cubit;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key("address_at_index_$index"),
      onTap: () {
        cubit.changeSelectedAddress(index);
      },
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: cubit.selectedAddressIndex == index
                  ? AppColors.lightGreen.withOpacity(0.1)
                  : null,
              border: Border.all(color: AppColors.borderColor),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MyImage.svgAssets(
                  url: 'assets/images/profile/address.svg',
                  height: context.width * 0.1,
                  width: context.width * 0.1,
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                  child: AutoSizeText(
                    '${cubit.addresses[index].streetName}, '
                    'apartment: ${cubit.addresses[index].apartment}, '
                    'state: ${cubit.addresses[index].state}, '
                    'postal code: ${cubit.addresses[index].zipCode}',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 12,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  width: 17,
                ),
                InkWell(
                  key: index == 0 ? deleteAddressKey : null,
                  onTap: () {
                    ConfirmCancelDialog(
                        context: context,
                        title: tr('sure_delete_address'),
                        onConfirm: () {
                          cubit.deleteAddress(index);
                        });
                  },
                  child: MyImage.svgAssets(
                    url: 'assets/images/profile/trash.svg',
                    height: context.width * 0.05,
                    width: context.width * 0.05,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
