import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/public_module/focus_node_model.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/keyboard_actions_widget.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/phone_number_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/simple_text_field.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/controller/shipping_location_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/view/component/city_drop_down_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/view/component/country_list_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/view/component/default_address_checkbox_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';

class ShippingLocationPage extends StatefulWidget {
  const ShippingLocationPage({super.key});

  @override
  State<ShippingLocationPage> createState() => _ShippingLocationPageState();
}

class _ShippingLocationPageState extends State<ShippingLocationPage> {
  @override
  void initState() {
    /// to prevent show pinCode when service take time
    isLocalAuth = true;
    sl<ShippingLocationCubit>().determineAddressDetails().then((dynamic value) {
      isLocalAuth = false;
    }).catchError((dynamic e) {
      isLocalAuth = false;
    }).whenComplete(() {
      isLocalAuth = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ShippingLocationCubit>.value(
      value: sl<ShippingLocationCubit>(),
      child: BlocBuilder<ShippingLocationCubit, ShippingLocationState>(
        builder: (BuildContext context, ShippingLocationState shippingState) {
          final ShippingLocationCubit cubit = BlocProvider.of(context);
          return BlocProvider<BeneficiaryCubit>.value(
            value: sl<BeneficiaryCubit>(),
            child: BlocBuilder<BeneficiaryCubit, BeneficiaryState>(
              builder: (BuildContext context, BeneficiaryState beneficiaryState) {
                return MainScaffold(
                  appBarWidget: MainAppBar(
                    title: tr('shipping_location'),
                  ),
                  scaffold: Builder(builder: (BuildContext context) {
                    if (shippingState is ShippingLocationCurrentPositionLoad ||
                        shippingState is ShippingLocationAddAddressLoad ||
                        beneficiaryState is BeneficiaryLoadingState) {
                      return const Center(
                        child: NativeLoading(),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: KeyboardActionsWidget(
                          focusNodeModels: <FocusNodeModel>[
                            FocusNodeModel(focusNode: cubit.streetFocusNode),
                            FocusNodeModel(focusNode: cubit.houseNumberFocusNode),
                            FocusNodeModel(focusNode: cubit.countryFocusNode),
                            FocusNodeModel(focusNode: cubit.cityFocusNode),
                            FocusNodeModel(focusNode: cubit.stateFocusNode),
                            FocusNodeModel(focusNode: cubit.zipCodeFocusNode),
                            FocusNodeModel(focusNode: cubit.phoneNumberFocusNode),
                          ],
                          child: SingleChildScrollView(
                            key: shippingLocationListKey,
                            child: Form(
                              key: cubit.globalKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  /// Street Name
                                  SimpleTextField(
                                    key: streetNameTextFieldKey,
                                    controller: cubit.streetNameController,
                                    title: tr('street_name'),
                                    focusNode: cubit.streetFocusNode,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  /// House / Apartment number
                                  SimpleTextField(
                                    key: houseNumberTextFieldKey,
                                    controller: cubit.houseNumberController,
                                    focusNode: cubit.houseNumberFocusNode,
                                    title: tr('house_apartment_number'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  AutoSizeText(tr('country')),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Focus(
                                    focusNode: cubit.countryFocusNode,
                                    child: CountryListWidget(
                                      showCurrency: false,
                                      shippingLocationCubit: cubit,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  AutoSizeText(tr('city')),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Focus(
                                    focusNode: cubit.cityFocusNode,
                                    child: CityDropDownWidget(
                                        cubit: cubit, shippingState: shippingState),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  /// State/Province
                                  SimpleTextField(
                                    key: stateTextFieldKey,
                                    controller: cubit.stateController,
                                    title: tr('state_province'),
                                    focusNode: cubit.stateFocusNode,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  /// Zip-code
                                  SimpleTextField(
                                    key: postalCodeTextFieldKey,
                                    controller: cubit.postalCodeController,
                                    title: tr('zip_code'),
                                    focusNode: cubit.zipCodeFocusNode,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),

                                  /// Phone Number
                                  PhoneNumberTextField(
                                    key: phoneNumberTextFieldKey,
                                    phoneTitle: tr('phone_number'),
                                    phoneNumberController: cubit.phoneNumberController,
                                    phoneNumberFocusNode: cubit.phoneNumberFocusNode,
                                    hasPrefix: false,
                                    phoneHint: tr('input'),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  DefaultAddressCheckboxWidget(cubit: cubit),

                                  const SizedBox(
                                    height: 10,
                                  ),
                                  LoadingButton(
                                    key: confirmAddAddressButtonKey,
                                    isLoading: false,
                                    title: tr('save'),
                                    onTap: () async {
                                      if (cubit.globalKey.currentState!.validate()) {
                                        final bool value = await cubit.addAddress(
                                          countryUUID:
                                              context.read<BeneficiaryCubit>().currentCountry!.uuid,
                                          //TODO: Refactor change to city uuid
                                          cityUUID: cubit.currentCity!.uuid!,
                                        );
                                        if (value) {
                                          MyToast(tr('address_added_successfully'));
                                        } else {
                                          MyToast(tr('something_went_wrong'));
                                        }
                                        CustomNavigator.instance.pop();
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
