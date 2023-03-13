import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/country.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/country_list_model.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/currency.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/currency_list_model.dart';
import 'package:res_pay_merchant/core/public_module/provider/repos/currency_repo.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/constants.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/controller/gift_cubit/gift_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_state.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/busienss/res_app_method_type.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/busienss/trasnfer_method_types.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_options/transfer_options_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/created_beneficiary.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/repos/beneficiary/beneficiary_repo.dart';

part 'beneficiary_state.dart';

class BeneficiaryCubit extends Cubit<BeneficiaryState> {
  final CurrencyRepository _currencyRepository;

  GlobalKey<FormState> currentFormKey = GlobalKey<FormState>();
  final BeneficiaryRemoteRepo _beneficiaryRemoteRepo;

  BeneficiaryCubit(this._beneficiaryRemoteRepo, this._currencyRepository)
      : super(BeneficiaryInitial()) {
    init();
  }

  /// Focus Nodes
  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode accountNumberFocusNode = FocusNode();
  final FocusNode ibanNumberFocusNode = FocusNode();
  final FocusNode swiftCodeFocusNode = FocusNode();

  void setCurrentFormKey(GlobalKey<FormState> value) {
    currentFormKey = value;
  }

  String currentInFavourite = "";
  int currentTransferTypeTapIndex = 0;

  void setCurrentInFavourite(String value) {
    currentInFavourite = value;

    emit(TapIsChanged());
  }

  void setCurrentTransferTapIndex(int value) {
    currentTransferTypeTapIndex = value;
    emit(TapIsChanged());
  }

  bool isInFav(String beneficiaryUUID) {
    return beneficiaries
        .where((Beneficiary element) => element.uuid == beneficiaryUUID && element.isFavorite!)
        .toList()
        .isNotEmpty;
  }

  int currentTransferCategoryTapIndex = 0;

  void updateState() {
    emit(BeneficiaryInitial());
  }

  void phoneNumberState() {
    if (phoneNumberError != "") {
      phoneNumberError = "";
    }
    emit(BeneficiaryInitial());
  }

  void accountNumberState() {
    if (accountNumberError != "") {
      accountNumberError = "";
    }
    emit(BeneficiaryInitial());
  }

  void ibanNumberState() {
    if (ibanError != "") {
      ibanError = "";
    }
    emit(BeneficiaryInitial());
  }

  /// text fields

  TextEditingController searchBarController = TextEditingController();

  String? iban;

  String? swiftCode;
  String? phoneNumber;
  String? accountNumber;
  String? firstName;
  String? lastName;

  /// drop down fields
  String? currentRelationShip;
  String? currentWalletName;
  Country? currentCountry;
  Currency? currentCurrency;
  Country? currentNationality;

  /// errors
  bool isApiErrors = false;
  String phoneNumberError = "";
  String accountNumberError = "";
  String ibanError = "";
  String swiftCodeError = "";

  /// lists
  List<Beneficiary> beneficiaries=<Beneficiary>[];
  List<Country>? countries;
  List<Currency>? currencies;

  /// start method
  Future<void> init() async {
    emit(BeneficiaryLoadingState());
    await getCurrencies();
    await getCountries();
    emit(BeneficiaryLoadedState());
  }

  /// to set correct method type when user chose one from list of transfers
  void configurationWhenTransferMethodChanged(String value, int index) {
    resetApiErrors();
    reset();
    emit(CorrectConfigurationDone());
  }

  /// set New Values Methods (tested)
  void setCurrentCurrency(Currency currency) {
    currentCurrency = currency;
    emit(DropDownItemChosen());
  }

  void setCurrentWalletName(String value) {
    currentWalletName = value;
    emit(DropDownItemChosen());
  }

  void setCurrentNationality(Country nationality) {
    currentNationality = nationality;
    emit(DropDownItemChosen());
  }

  void setCurrentCountry(Country country) {
    currentCountry = country;
    emit(DropDownItemChosen());
  }

  void setCurrentRelationShip(String value) {
    currentRelationShip = value;
    emit(DropDownItemChosen());
  }

  /// reset methods (tested)
  void reset() {
    searchBarController.clear();
    currentCurrency = null;
    currentCountry = null;
    currentNationality = null;
    currentRelationShip = null;
    currentWalletName = null;
    resetApiErrors();
    setCurrentTransferToTapIndex(currentTransferCategoryTapIndex);
  }

  void resetApiErrors() {
    phoneNumberError = "";
    accountNumberError = "";
    ibanError = "";
    isApiErrors = false;
  }

  /// this variable tell me if there is api errors and if yes ,navigate to form text fields to make user enter another data
  void resetApiErrorsValue() {
    isApiErrors = false;
  }

  /// beneficiaries filtering methods (tested)
  void filterByNameUsingEnteredTextInSearchBar(String name,ServiceType serviceType) {
    switch (serviceType){
      case ServiceType.gift :
        if(sl<GiftCubit>().currentTapIndex==1){
          sl<GiftCubit>()..searchInReceivedGifts(name)..emit(GiftLoadedState());
        }
        break;
      case ServiceType.request_money :
        if(sl<RequestCubit>().currentTapIndex==1){
          if(sl<RequestCubit>().state is! RequestLoadingState){
            sl<RequestCubit>()..searchInReceivedRequests(name)..emit(RequestInitial());
          }
        }
        break;
      case ServiceType.transfer :
        break;
    }
    emit(BeneficiaryFiltered());
  }

  void setCurrentTransferToTapIndex(int value) {
    currentTransferCategoryTapIndex = value;
    emit(TransferToTapIndexChanged());
  }

  bool isNameContainsSearchBarText(Beneficiary beneficiary) {
    return "${beneficiary.firstName!} ${beneficiary.lastName!}".contains(searchBarController.text);
  }

  List<Beneficiary> filterBeneficiaries(ServiceType? currentMethod) {
    switch (currentTransferCategoryTapIndex) {
      case 0:
        return beneficiaries
            .where((Beneficiary element) => isNameContainsSearchBarText(element))
            .toList();
      case 1:
        if (currentMethod != null) {
          return beneficiaries
              .where((Beneficiary element) {
                if(currentMethod==ServiceType.transfer){
                  return (<ServiceType>[currentMethod,ServiceType.gift].contains(element.method)|| element.methodType == "RES App") && element.isFavorite! && isNameContainsSearchBarText(element);
                }
                else{
                  return (element.method == currentMethod || element.methodType == "RES App") && element.isFavorite! && isNameContainsSearchBarText(element);
                }
              })
              .toList();
        } else {
          return beneficiaries
              .where((Beneficiary element) =>
          element.isFavorite! && isNameContainsSearchBarText(element))
              .toList();
        }
      case 2:
        return beneficiaries
            .where((Beneficiary element) =>
        element.type == "external" && isNameContainsSearchBarText(element))
            .toList();
      case 3:
        return beneficiaries
            .where((Beneficiary element) =>
        element.type == "internal" && isNameContainsSearchBarText(element))
            .toList();
      default:
        return beneficiaries
            .where((Beneficiary element) => isNameContainsSearchBarText(element))
            .toList();
    }
  }

  //
  bool isButtonEnabled() {
    return isValidForm(currentFormKey);
  }

  bool isValidForm(GlobalKey<FormState> currentFormKey) {
    return currentFormKey.currentState?.validate() ?? false;
  }

  void resetToInitialState() {
    emit(BeneficiaryInitial());
  }

  /// api calls
  Future<Beneficiary?> addNewBeneficiary(TransferMethodType transferMethodType) async {
    // try {
    //
    // } catch (e) {
    //   emit(AddNewTransferBeneficiaryErrorState());
    //   return null;
    // }
    Beneficiary? beneficiary;
    Map<String, dynamic> inputs = <String, dynamic>{};
    if (currentTransferTypeTapIndex == 0) {
      if (sl<TransferOptionsCubit>()
          .internationalTransferTypes!
          .contains(transferMethodType.methodTypeName)) {
        inputs = transferMethodType.fillInternationalData().toJson();
      } else {
        inputs = TransferResAppMethodType("RES App", 2).fillInternationalData().toJson();
      }
    } else {
      if (sl<TransferOptionsCubit>().localTransferTypes!.contains(transferMethodType.methodTypeName)) {
        inputs = transferMethodType.fillLocalData().toJson();
      } else {
        inputs = TransferResAppMethodType("RES App", 2).fillInternationalData().toJson();
      }
    }
    emit(BeneficiaryLoadingState());
    final Either<Failure, ParentModel> result = await _beneficiaryRemoteRepo.addNewTransferBeneficiary(inputs: inputs);
    result.fold((Failure l) {
      handleAddingNewBeneficiaryFailed(l);
      CustomNavigator.instance.pop();
      return null;
    }, (ParentModel r) async {
      resetApiErrors();
      emit(BeneficiaryAddedInServer());
      beneficiary =(r as CreatedBeneficiaryModel).beneficiary;
    });
    return beneficiary;
  }

  /// run when the adding new beneficiary not done in success
  void handleAddingNewBeneficiaryFailed(Failure apiFailure) {
    if (apiFailure.errors.isNotEmpty) {
      isApiErrors = true;
      if (apiFailure.errors['error'] != null) {
        setErrorsWhenErrorsInOneKey(apiFailure);
      } else {
        phoneNumberError = apiFailure.errors["phone_number"] != null
            ? (apiFailure.errors["phone_number"] as List<dynamic>).first as String
            : "";
        ibanError = apiFailure.errors["iban"] != null
            ? (apiFailure.errors["iban"] as List<dynamic>).first as String
            : "";
        accountNumberError = apiFailure.errors["account_number"] != null
            ? (apiFailure.errors["account_number"] as List<dynamic>).first as String
            : "";
        emit(AddNewTransferBeneficiaryErrorState());
      }
    }
  }

  /// in case errors coming in one key called "error"
  void setErrorsWhenErrorsInOneKey(Failure apiFailure) {
    if (apiFailure.errors['error'] == "This account number already exist in your beneficiaries!") {
      accountNumberError = apiFailure.errors['error'] as String;
    } else {
      accountNumberError = "";
    }
    if (apiFailure.errors['error'] == "This IBAN already exist in your beneficiaries!") {
      ibanError = apiFailure.errors['error'] as String;
    } else {
      ibanError = "";
    }
    if (apiFailure.errors['error'] == tr("user_not_found") ||
        apiFailure.errors['error'] == tr("beneficiary_already_exists")) {
      phoneNumberError = apiFailure.errors['error'] as String;
    } else {
      phoneNumberError = "";
    }
    emit(AddNewTransferBeneficiaryErrorState());
  }

  Future<void> getCountries() async {
    try {
      final Either<Failure, ParentModel> result = await _currencyRepository.getCountries();
      result.fold((Failure l) {}, (ParentModel r) {
        countries = (r as CountryListModel).countries;
      });
    } catch (e) {
      emit(CountriesError());
    }
  }

  Future<void> getCurrencies() async {
    try {
      (await _currencyRepository.getCurrencies()).fold(
          (Failure l) => null, (ParentModel r) => currencies = (r as CurrencyListModel).currencies);
    } catch (e) {
      emit(FetchAllCurrenciesErrorState());
    }
  }

  Future<void> favouriteToggle({required String beneficiaryUUID}) async {
    final int index = beneficiaries.indexWhere(
      (Beneficiary element) => element.uuid == beneficiaryUUID,
    );
    try {
      beneficiaries[index].isFavorite = !beneficiaries[index].isFavorite!;

      emit(FavouriteToggleLoading());
      (await _beneficiaryRemoteRepo.favouriteToggle(beneficiaryUUiD: beneficiaryUUID)).fold(
          (Failure l) {
        beneficiaries[index].isFavorite = !beneficiaries[index].isFavorite!;
        emit(FavouriteToggleError());
      }, (ParentModel r) async {
        emit(FavouriteToggleLoaded());
      });
    } catch (e) {
      beneficiaries[index].isFavorite = !beneficiaries[index].isFavorite!;
      emit(FavouriteToggleError());
    }
  }

  List<String> relationships = <String>[];

  Future<void> getBeneficiary({required ServiceType serviceType}) async {
    Either<Failure, ParentModel>? result;
    try {
      emit(BeneficiaryLoadingState());
      //String? method;

      /// todo use that when filter done from service
      // if(!(<ServiceType>[ServiceType.gift,ServiceType.request_money].contains(serviceType)&&showLocalBeneficiaryInRequestAndGift)){
      //   method = serviceType.name.replaceAll("_", " ").capitalize();
      // }
      //
      result = await _beneficiaryRemoteRepo.getBeneficiary();

      result.fold((Failure l) {
        emit(FetchAllBeneficiariesErrorState());
      }, (ParentModel r) {

        beneficiaries = (r as BeneficiariesModel).beneficiaries??<Beneficiary>[];
        /// todo removed when backend return only transfer beneficiary
        switch (serviceType) {
          case ServiceType.transfer:
            beneficiaries = r
                .beneficiaries!
                .where((Beneficiary element) => element.methodType != "Request Money")
                .toList();
            break;
          case ServiceType.request_money:
            beneficiaries = beneficiaries.where((Beneficiary element) =>
            element.methodType == 'RES App' || element.methodType == 'Request Money')
                .toList();
            break;
          case ServiceType.gift:
            beneficiaries = beneficiaries.where((Beneficiary element) =>
            element.methodType == 'RES App' || element.methodType == 'Gift')
                .toList();
            break;
        }
        relationships = r.relations!;
        emit(BeneficiaryLoadedState());
      });
    } catch (e) {
      emit(FetchAllBeneficiariesErrorState());
    }
  }

  Future<void> deleteBeneficiary(int index) async
  {
    emit(BeneficiaryLoadingState());
    (await _beneficiaryRemoteRepo.deleteBeneficiry(
        uuid: beneficiaries[index].uuid!, ))
        .fold((Failure l) {
      emit(BeneficiaryFailure());
    }, (List<BeneficiariesModel> r) {
      final int newIndex = beneficiaries.indexWhere(
              (Beneficiary element) =>
          element.uuid == beneficiaries[index].uuid);

      beneficiaries.removeAt(newIndex);

      // notificationModels[index].readAt = DateTime.now();
      emit(DeleteBeneficiry());
    });

  }

  void resetSearchBar(ServiceType serviceType) {
    searchBarController.clear();
    switch (serviceType){
      case ServiceType.gift :
        if(sl<GiftCubit>().currentTapIndex==1){
          sl<GiftCubit>()..searchInReceivedGifts("")..emit(GiftLoadedState());
        }
        else{
          emit(BeneficiaryFiltered());
        }
        break;
      case ServiceType.request_money :
        if(sl<RequestCubit>().currentTapIndex==1){
          sl<RequestCubit>()..requests..emit(RequestInitial());
        }
        else{
          emit(BeneficiaryFiltered());
        }
        break;
      case ServiceType.transfer :
        emit(BeneficiaryFiltered());
        break;
    }

    emit(SearchBarClearSate());
  }
}
