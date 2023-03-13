import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/country.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/constants.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_state.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/model/money_request_filter_enum.dart';
import 'package:res_pay_merchant/features/payment/modules/request/view/page/request_tabs.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';

import '../../core/global_mocks/set_up_test.dart';

void main() {
  late RequestCubit requestCubit;
  late BeneficiaryCubit beneficiaryCubit;

  setUpAll(() {
    /// Mock Cubits Data to test
    mockTest();

    requestCubit = sl<RequestCubit>();
    beneficiaryCubit = sl<BeneficiaryCubit>();

    when(requestCubit.stream)
        .thenAnswer((Invocation realInvocation) => Stream.fromIterable([
              RequestInitial(),
              CategoryChanged(),
              RequestTextFieldValueChanged(),
              DataVerificationDone(),
              CategoryIsChanged(),
              TransferCountryChanged(const Country(
                  id: 1,
                  name: 'Egypt',
                  uuid: 'uuid',
                  code: 'code',
                  currencyCode: 'currencyCode')),
              RequestRequiredFieldsExist(),
              RequestsFilterStatusChanged(MoneyRequestFilterEnum.accepted),
              RequestMoneyDataVerificationDone(),
            ]));
    when(beneficiaryCubit.stream)
        .thenAnswer((Invocation realInvocation) => Stream.fromIterable([
              BeneficiaryInitial(),
              TextFieldValueChanged(),
              NavigateToAmount(),
              BeneficiaryLoadingState(),
              BeneficiaryAddedInServer(),
              NavigateToSummary(),
              CurrencyChanged(),
              FetchAllCurrenciesErrorState(),
              CountryChanged(),
            ]));

    when(requestCubit.state).thenReturn(DataVerificationDone());
    when(beneficiaryCubit.state).thenReturn(CurrencyChanged());
    when(requestCubit.currentTapIndex).thenReturn(0);
    when(beneficiaryCubit.searchBarController)
        .thenReturn(TextEditingController());
    when(beneficiaryCubit.filterBeneficiaries(ServiceType.request_money))
        .thenReturn([
      Beneficiary(
          uuid: 'uuid',
          createdAt: '2011',
          isActive: true,
          phoneNumber: '0111111111',
          userUUID: 'userUUID',
          type: 'request',
          firstName: 'Mohamed',
          imageUrl: 'www.google.com',
          accountNumber: '1111111111111',
          bankName: 'Bank',
          countryId: 1,
          currencyId: 1,
          iban: 'EG65156161951561651614654',
          isFavorite: true,
          lastName: 'Ali',
          method: ServiceType.request_money,
          methodType: 'request',
          nationalityId: 1,
          relation: 'Parents',
          swiftCode: '3as21d65sa1',
          walletName: 'aaa')
    ]);
    when(beneficiaryCubit.isInFav('uuid')).thenReturn(true);
    when(beneficiaryCubit.currentTransferCategoryTapIndex).thenReturn(0);
    when(beneficiaryCubit.currentInFavourite).thenReturn('uuid');
  });

  group('Request Page Test', () {
    testWidgets('Request Page Test', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: RequestTabs()));

      expect(find.text('Transfer To'), findsOneWidget);
    });
  });
}
