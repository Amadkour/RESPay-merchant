import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/country.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/country_list_model.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/currency.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/currency_list_model.dart';
import 'package:res_pay_merchant/core/public_module/provider/repos/currency_repo.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/constants.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/busienss/res_app_method_type.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/created_beneficiary.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/repos/beneficiary/beneficiary_repo.dart';

import '../beneficiary_values.dart';
import 'beneficiary_controller_test.mocks.dart';

@GenerateMocks(<Type>[BeneficiaryRemoteRepo, CurrencyRepository])
void main() async {
  late MockBeneficiaryRemoteRepo beneficiaryRemoteRepo;
  late MockCurrencyRepository currencyRepository;
  final ApiFailure serverError = ApiFailure(errors: <String, dynamic>{});
  setUpAll(() {
    beneficiaryRemoteRepo = MockBeneficiaryRemoteRepo();
    currencyRepository = MockCurrencyRepository();
  });

  group('test group set values in beneficiary cubit', () {
    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'verify that init method return success',
      build: () => BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository),
      act: (BeneficiaryCubit bloc) {},
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<CountriesError>(),
        isA<BeneficiaryLoadedState>(),
      ],
    );

    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'verify that setCurrentCurrency method return success',
      build: () => BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository),
      act: (BeneficiaryCubit bloc) => bloc.setCurrentCurrency(const Currency(
          id: 1,
          uuid: "uuid",
          iso2Code: "test",
          iso3Code: "test",
          isActive: true,
          name: "test",
          country: "test")),
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<DropDownItemChosen>(),
        isA<CountriesError>(),
        isA<BeneficiaryLoadedState>(),
      ],
    );

    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'verify that setCurrentWalletName method return success',
      build: () => BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository),
      act: (BeneficiaryCubit bloc) => bloc.setCurrentWalletName("test"),
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<DropDownItemChosen>(),
        isA<CountriesError>(),
        isA<BeneficiaryLoadedState>(),
      ],
    );

    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'verify that setCurrentNationality method return success',
      build: () => BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository),
      act: (BeneficiaryCubit bloc) => bloc.setCurrentNationality(const Country(
          id: 1,
          name: "test",
          code: "test",
          currencyCode: "test",
          uuid: 'uuid')),
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<DropDownItemChosen>(),
        isA<CountriesError>(),
        isA<BeneficiaryLoadedState>(),
      ],
    );
    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'verify that setCurrentCountry method return success',
      build: () => BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository),
      act: (BeneficiaryCubit bloc) => bloc.setCurrentCountry(const Country(
          id: 1,
          name: "test",
          code: "test",
          currencyCode: "test",
          uuid: 'uuid')),
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<DropDownItemChosen>(),
        isA<CountriesError>(),
        isA<BeneficiaryLoadedState>(),
      ],
    );
    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'verify that setCurrentRelationShip method return success',
      build: () => BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository),
      act: (BeneficiaryCubit bloc) => bloc.setCurrentRelationShip("test"),
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<DropDownItemChosen>(),
        isA<CountriesError>(),
        isA<BeneficiaryLoadedState>(),
      ],
    );
  });

  group('test group reset methods in beneficiary cubit', () {
    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'verify that reset method return success',
      build: () => BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository),
      act: (BeneficiaryCubit bloc) => bloc.reset(),
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<TransferToTapIndexChanged>(),
        isA<CountriesError>(),
        isA<BeneficiaryLoadedState>(),
      ],
    );

    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'verify that resetApiErrors method return success',
      build: () => BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository),
      act: (BeneficiaryCubit bloc) => bloc.resetApiErrors(),
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<CountriesError>(),
        isA<BeneficiaryLoadedState>(),
      ],
    );
    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'verify that resetApiErrorsValue method return success',
      build: () => BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository),
      act: (BeneficiaryCubit bloc) => bloc.resetApiErrorsValue(),
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<CountriesError>(),
        isA<BeneficiaryLoadedState>(),
      ],
    );
  });

  group('test group beneficiaries filtering methods in beneficiary cubit', () {
    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'verify that setCurrentTransferToTapIndex method return success',
      build: () => BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository),
      act: (BeneficiaryCubit bloc) => bloc.setCurrentTransferToTapIndex(0),
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<TransferToTapIndexChanged>(),
        isA<CountriesError>(),
        isA<BeneficiaryLoadedState>(),
      ],
    );
    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'verify that filterByName method return success',
      build: () => BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository),
      act: (BeneficiaryCubit bloc) =>
          bloc.filterByNameUsingEnteredTextInSearchBar(
              "test", ServiceType.transfer),
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<BeneficiaryFiltered>(),
        isA<CountriesError>(),
        isA<BeneficiaryLoadedState>(),
      ],
    );
    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'verify that isNameContainsSearchBarText method return success',
      build: () => BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository),
      act: (BeneficiaryCubit bloc) => bloc.isNameContainsSearchBarText(
          Beneficiary(firstName: "hussein", lastName: "hamed")),
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<CountriesError>(),
        isA<BeneficiaryLoadedState>(),
      ],
    );
    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'verify that getCorrectList method return success',
      build: () => BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository),
      act: (BeneficiaryCubit bloc) => bloc.filterBeneficiaries(null),
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<CountriesError>(),
        isA<BeneficiaryLoadedState>(),
      ],
    );
  });

  group('test group favourites operations methods in beneficiary cubit', () {});

  group('test api calls methods in beneficiary cubit', () {
    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'onSuccess Test getAllBeneficiary',
      build: () {
        when(beneficiaryRemoteRepo.getBeneficiary(method: "Transfer"))
            .thenAnswer((Invocation realInvocation) async =>
                Right<Failure, ParentModel>(BeneficiariesModel()));
        return BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository);
      },
      act: (BeneficiaryCubit bloc) {
        bloc.getBeneficiary(serviceType: ServiceType.transfer);
      },
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<BeneficiaryLoadingState>(),
        isA<CountriesError>(),
        isA<BeneficiaryLoadedState>(),
      ],
      verify: (BeneficiaryCubit bloc) =>
          verify(beneficiaryRemoteRepo.getBeneficiary(method: "Transfer")),
    );

    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'onFail Test getAllBeneficiary',
      build: () {
        when(beneficiaryRemoteRepo.getBeneficiary(method: "Transfer"))
            .thenAnswer((Invocation realInvocation) async =>
                Left<Failure, ParentModel>(serverError));
        return BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository);
      },
      act: (BeneficiaryCubit bloc) {
        bloc.getBeneficiary(serviceType: ServiceType.transfer);
      },
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<BeneficiaryLoadingState>(),
        isA<CountriesError>(),
        isA<FetchAllBeneficiariesErrorState>(),
        isA<BeneficiaryLoadedState>(),
      ],
      verify: (BeneficiaryCubit bloc) =>
          verify(beneficiaryRemoteRepo.getBeneficiary(method: "Transfer")),
    );

    ///////////////////////////////////////////// getCountries /////////////////////////////////////////////////

    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'onSuccess Test getCountries',
      build: () {
        when(currencyRepository.getCountries()).thenAnswer(
            (Invocation realInvocation) async =>
                Right<Failure, ParentModel>(CountryListModel()));
        return BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository);
      },
      act: (BeneficiaryCubit bloc) {
        bloc.getCountries();
      },
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<BeneficiaryLoadedState>(),
      ],
    );
    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'onFail Test getCountries',
      build: () {
        when(currencyRepository.getCountries()).thenAnswer(
            (Invocation realInvocation) async =>
                Left<Failure, ParentModel>(serverError));
        return BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository);
      },
      act: (BeneficiaryCubit bloc) {
        bloc.getCountries();
      },
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<BeneficiaryLoadedState>(),
      ],
    );

    ///////////////////////////////////////////// getCountries ///////////////////F//////////////////////////////

    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'onSuccess Test getCountries',
      build: () {
        when(currencyRepository.getCurrencies()).thenAnswer(
            (Invocation realInvocation) async =>
                Right<Failure, ParentModel>(CurrencyListModel()));
        return BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository);
      },
      act: (BeneficiaryCubit bloc) {
        bloc.getCurrencies();
      },
      expect: () =>
          <TypeMatcher<BeneficiaryState>>[isA<BeneficiaryLoadedState>()],
    );
    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'onFail Test getCurrencies',
      build: () {
        when(currencyRepository.getCurrencies()).thenAnswer(
            (Invocation realInvocation) async =>
                Left<Failure, ParentModel>(serverError));
        return BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository);
      },
      act: (BeneficiaryCubit bloc) {
        bloc.getCurrencies();
      },
      expect: () =>
          <TypeMatcher<BeneficiaryState>>[isA<BeneficiaryLoadedState>()],
    );
    ///////////////////////////////////////////////// addNewTransferBeneficiary /////////////////////////////////////////////////

    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'onSuccess Test addNewTransferBeneficiary',
      build: () {
        when(beneficiaryRemoteRepo.addNewTransferBeneficiary(
                inputs: successAddNewTransferBeneficiaryInput))
            .thenAnswer((Invocation realInvocation) async =>
                Right<Failure, ParentModel>(CreatedBeneficiaryModel()));
        return BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository);
      },
      act: (BeneficiaryCubit bloc) {
        bloc.currentTransferTypeTapIndex = 0;
        bloc.currentRelationShip = "Relatives / Friends";
        bloc.currentCountry = const Country(
            id: 1,
            name: "name",
            uuid: "uuid",
            code: "code",
            currencyCode: "currencyCode");
        bloc.currentCurrency = const Currency(
            id: 1,
            uuid: "uuid",
            iso2Code: "iso2Code",
            iso3Code: "iso3Code",
            isActive: true,
            name: "name",
            country: "country");
        bloc.firstName = "New Beneficiary";
        bloc.lastName = "hussein";
        bloc.phoneNumber = "05019069388";
        bloc.addNewBeneficiary(TransferResAppMethodType("RES App", 2));
      },
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<BeneficiaryLoadingState>(),
        isA<BeneficiaryAddedInServer>(),
        isA<BeneficiaryLoadedState>(),
      ],
      verify: (BeneficiaryCubit bloc) => verify(
              beneficiaryRemoteRepo.addNewTransferBeneficiary(
                  inputs: successAddNewTransferBeneficiaryInput))
          .called(1),
    );
    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'onFail Test addNewTransferBeneficiary',
      build: () {
        when(beneficiaryRemoteRepo.addNewTransferBeneficiary(
                inputs: failureAddNewTransferBeneficiaryInput))
            .thenAnswer((Invocation realInvocation) async =>
                Left<Failure, ParentModel>(serverError));
        return BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository);
      },
      act: (BeneficiaryCubit bloc) {
        bloc.currentTransferTypeTapIndex = 0;
        bloc.addNewBeneficiary(TransferResAppMethodType("RES App", 2));
      },
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<BeneficiaryLoadingState>(),
        isA<AddNewTransferBeneficiaryErrorState>(),
        isA<BeneficiaryLoadedState>()
      ],
      verify: (BeneficiaryCubit bloc) => verify(
              beneficiaryRemoteRepo.addNewTransferBeneficiary(
                  inputs: failureAddNewTransferBeneficiaryInput))
          .called(1),
    );

    blocTest<BeneficiaryCubit, BeneficiaryState>(
      'onSuccess Test favourite toggle',
      build: () {
        when(beneficiaryRemoteRepo.favouriteToggle(
                beneficiaryUUiD: "sdfsdfdsfsfsf"))
            .thenAnswer((Invocation realInvocation) async =>
                Left<Failure, ParentModel>(serverError));
        return BeneficiaryCubit(beneficiaryRemoteRepo, currencyRepository);
      },
      act: (BeneficiaryCubit bloc) {
        bloc.currentTransferTypeTapIndex = 0;
        bloc.favouriteToggle(beneficiaryUUID: "sdfsdfdsfsfsf");
      },
      expect: () => <TypeMatcher<BeneficiaryState>>[
        isA<BeneficiaryLoadingState>(),
        isA<AddNewTransferBeneficiaryErrorState>(),
        isA<BeneficiaryLoadedState>()
      ],
      verify: (BeneficiaryCubit bloc) => verify(beneficiaryRemoteRepo
              .favouriteToggle(beneficiaryUUiD: "sdfsdfdsfsfsf"))
          .called(1),
    );
  });
}
