import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/country.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/address_bottom_sheet.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/simple_text_field.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/controller/shipping_location_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/model/address_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/model/city_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/view/component/city_drop_down_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/view/component/country_list_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/view/component/default_address_checkbox_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';

import '../../../../integration_test/helper/helper.dart';
import '../../../../integration_test/shared/values.dart';
import 'shipping_locations_test.mocks.dart';

@GenerateMocks(<Type>[ShippingLocationCubit, BeneficiaryCubit])
void main() {
  late MockShippingLocationCubit mockShippingLocationCubit;
  late MockBeneficiaryCubit mockBeneficiaryCubit;
  late final List<AddressModel> privacyList = <AddressModel>[
    AddressModel(
        state: "",
        apartment: "test title",
        city: "test description",
        streetName: "test",
        zipCode: "233",
        countryUUID: "dsd",
        uuid: "334fdf"),
  ];
  setUp(() {
    mockShippingLocationCubit = MockShippingLocationCubit();
    mockBeneficiaryCubit = MockBeneficiaryCubit();
    when(mockShippingLocationCubit.streetFocusNode).thenReturn(FocusNode());
    when(mockShippingLocationCubit.houseNumberFocusNode)
        .thenReturn(FocusNode());
    when(mockShippingLocationCubit.countryFocusNode).thenReturn(FocusNode());
    when(mockShippingLocationCubit.cityFocusNode).thenReturn(FocusNode());
    when(mockShippingLocationCubit.stateFocusNode).thenReturn(FocusNode());
    when(mockShippingLocationCubit.zipCodeFocusNode).thenReturn(FocusNode());
    when(mockShippingLocationCubit.phoneNumberFocusNode)
        .thenReturn(FocusNode());
    when(mockShippingLocationCubit.globalKey)
        .thenReturn(GlobalKey<FormState>());
    when(mockShippingLocationCubit.streetNameController)
        .thenReturn(TextEditingController(text: "test street"));
    when(mockShippingLocationCubit.houseNumberController)
        .thenReturn(TextEditingController(text: "house number 1"));
    when(mockShippingLocationCubit.stateController)
        .thenReturn(TextEditingController(text: "new state"));
    when(mockShippingLocationCubit.postalCodeController)
        .thenReturn(TextEditingController(text: "2332122"));
    when(mockShippingLocationCubit.phoneNumberController)
        .thenReturn(TextEditingController());
    when(mockShippingLocationCubit.currentCity).thenReturn(CityModel(
      uuid: "1231234fdsf",
      name: "city 1",
    ));
    when(mockShippingLocationCubit.cities).thenReturn(<CityModel>[
      CityModel(
        uuid: "1231234fdsf",
        name: "city 1",
      ),
    ]);
    when(mockShippingLocationCubit.selectedAddressIndex).thenReturn(0);
    when(mockShippingLocationCubit.isDefaultAddressCheckBoxValue)
        .thenReturn(false);
    when(mockBeneficiaryCubit.currentCountry).thenReturn(const Country(
        id: 1,
        name: "country 1",
        uuid: "432dsfds",
        code: "ddsf",
        currencyCode: "@3123"));
    when(mockBeneficiaryCubit.countries).thenReturn(<Country>[
      const Country(
          id: 1,
          name: "country 1",
          uuid: "432dsfds",
          code: "ddsf",
          currencyCode: "@3123")
    ]);
    final Stream<ShippingLocationState> stream =
        Stream<ShippingLocationState>.fromIterable(<ShippingLocationState>[
      ShippingLocationInitial(),
      ShippingLocationLoadLocation(),
      ShippingLocationLoadedLocation(),
    ]);
    when(mockShippingLocationCubit.stream).thenAnswer(
      (Invocation i) => stream,
    );
    when(mockShippingLocationCubit.state).thenAnswer(
      (Invocation i) => ShippingLocationLoadedLocation(),
    );
  });

  group('testing ShippingLocation screen', () {
    testWidgets('testing ShippingLocation view', (WidgetTester tester) async {
      when(mockShippingLocationCubit.addresses).thenReturn(privacyList);
      when(mockShippingLocationCubit.selectedAddressIndex).thenReturn(0);
      await tester.pumpWidget(BlocProvider<ShippingLocationCubit>(
        create: (BuildContext context) => mockShippingLocationCubit,
        child: MaterialApp(
            navigatorKey: globalKey,
            home: Scaffold(
              body: ListOfAddresses(
                  cubit: mockShippingLocationCubit,
                  buttonTitle: "send now",
                  state: ShippingLocationInitial()),
            )),
      ));
      expect(
          tester
              .widgetList(find.bySubtype<SingleShippingLocationItem>())
              .length,
          1);
      expect(find.text("send now"), findsOneWidget);
      expect(find.text(tr('add_new_address')), findsOneWidget);
    });
  });

  group('testing Add New Address Form screen', () {
    testWidgets('testing Add New Address Form (street name Field) screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider<ShippingLocationCubit>(
        create: (BuildContext context) => mockShippingLocationCubit,
        child: MaterialApp(
            navigatorKey: globalKey,
            home: Scaffold(
              body: SimpleTextField(
                controller: mockShippingLocationCubit.streetNameController,
                title: tr('street_name'),
                focusNode: mockShippingLocationCubit.streetFocusNode,
              ),
            )),
      ));
      expect(find.text("test street"), findsOneWidget);
    });

    testWidgets('testing Add New Address Form (country name Field) screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider<ShippingLocationCubit>(
        create: (BuildContext context) => mockShippingLocationCubit,
        child: MaterialApp(
            navigatorKey: globalKey,
            home: Scaffold(
              body: Focus(
                focusNode: mockShippingLocationCubit.countryFocusNode,
                child: DropDownOdCountriesBody(
                  shippingLocationCubit: mockShippingLocationCubit,
                  beneficiaryCubit: mockBeneficiaryCubit,
                ),
              ),
            )),
      ));
      await selectFromDropDownList(
          tester,
          countryItemInCountriesDropdownListFinder,
          countriesDropdownListFinder);
      expect(find.text("country 1"), findsOneWidget);
    });

    testWidgets('testing Add New Address Form (city name Field) screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider<ShippingLocationCubit>(
        create: (BuildContext context) => mockShippingLocationCubit,
        child: MaterialApp(
            navigatorKey: globalKey,
            home: Scaffold(
              body: Focus(
                focusNode: mockShippingLocationCubit.countryFocusNode,
                child: CityDropDownWidget(
                  shippingState: ShippingLocationInitial(),
                  cubit: mockShippingLocationCubit,
                ),
              ),
            )),
      ));
      final Finder dropdownItem = find.text('city 1').last;
      await selectFromDropDownList(
          tester, dropdownItem, citiesDropdownListFinder);
      expect(find.text("city 1"), findsOneWidget);
    });

    testWidgets('testing Add New Address Form (house Number Field) screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider<ShippingLocationCubit>(
        create: (BuildContext context) => mockShippingLocationCubit,
        child: MaterialApp(
            navigatorKey: globalKey,
            home: Scaffold(
              body: SimpleTextField(
                controller: mockShippingLocationCubit.houseNumberController,
                focusNode: mockShippingLocationCubit.houseNumberFocusNode,
                title: tr('house_apartment_number'),
              ),
            )),
      ));
      expect(find.text(tr('house_apartment_number')), findsOneWidget);
      expect(find.text("house number 1"), findsOneWidget);
    });

    testWidgets('testing Add New Address Form (state province Field) screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider<ShippingLocationCubit>(
        create: (BuildContext context) => mockShippingLocationCubit,
        child: MaterialApp(
            navigatorKey: globalKey,
            home: Scaffold(
              body: SimpleTextField(
                controller: mockShippingLocationCubit.stateController,
                title: tr('state_province'),
                focusNode: mockShippingLocationCubit.stateFocusNode,
              ),
            )),
      ));
      expect(find.text(tr('state_province')), findsOneWidget);
      expect(find.text("new state"), findsOneWidget);
    });

    testWidgets('testing Add New Address Form (state province Field) screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider<ShippingLocationCubit>(
        create: (BuildContext context) => mockShippingLocationCubit,
        child: MaterialApp(
            navigatorKey: globalKey,
            home: Scaffold(
              body: SimpleTextField(
                controller: mockShippingLocationCubit.postalCodeController,
                title: tr('zip_code'),
                focusNode: mockShippingLocationCubit.zipCodeFocusNode,
              ),
            )),
      ));
      expect(find.text(tr('zip_code')), findsOneWidget);
      expect(find.text("2332122"), findsOneWidget);
    });

    testWidgets(
        'testing Add New Address Form (DefaultAddressCheckboxWidget) screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider<ShippingLocationCubit>(
        create: (BuildContext context) => mockShippingLocationCubit,
        child: MaterialApp(
            navigatorKey: globalKey,
            home: Scaffold(
              body: DefaultAddressCheckboxWidget(
                  cubit: mockShippingLocationCubit),
            )),
      ));
      expect(find.text(tr('mark_default_address')), findsOneWidget);
      expect(mockShippingLocationCubit.isDefaultAddressCheckBoxValue, false);
      await tester.tap(defaultAddressCheckBoxFinder);
      await tester.pump();
      when(mockShippingLocationCubit.isDefaultAddressCheckBoxValue)
          .thenReturn(true);
      expect(mockShippingLocationCubit.isDefaultAddressCheckBoxValue, true);
    });

    testWidgets('testing Add New Address Form (Loading Button) screen',
        (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider<ShippingLocationCubit>(
        create: (BuildContext context) => mockShippingLocationCubit,
        child: MaterialApp(
            navigatorKey: globalKey,
            home: Scaffold(
                body: LoadingButton(
              key: confirmAddAddressButtonKey,
              isLoading: mockShippingLocationCubit.state
                  is ShippingLocationLoadedLocation,
              title: tr('save'),
              onTap: () async {
                if (mockShippingLocationCubit.globalKey.currentState!
                    .validate()) {
                  final bool value = await mockShippingLocationCubit.addAddress(
                    countryUUID: mockBeneficiaryCubit.currentCountry!.uuid,
                    //TODO: Refactor change to city uuid
                    cityUUID: mockShippingLocationCubit.currentCity!.uuid,
                  );
                  if (value) {
                    MyToast(tr('address_added_successfully'));
                  } else {
                    MyToast(tr('something_went_wrong'));
                  }
                  CustomNavigator.instance.pop();
                }
              },
            ))),
      ));

      final Finder initialWidget = find.byType(Text).first;

      await tester.tap(find.byType(LoadingButton));
      await tester.pump();

      final Finder newWidget = find.byType(CircularProgressIndicator).first;

      expect(initialWidget, isNot(newWidget));

      expect(find.text(tr('save')), findsOneWidget);
    });
  });
}
