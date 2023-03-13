import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/model/address_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/model/city_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/repository/shipping_location_repository.dart';

part 'shipping_location_state.dart';

class ShippingLocationCubit extends Cubit<ShippingLocationState> {
  ShippingLocationCubit(this._shippingLocationRepository)
      : super(ShippingLocationInitial()) {
    init();
  }

  final ShippingLocationRepository _shippingLocationRepository;

  /// ----------------------- Initialization -------------------- ///

  List<CityModel> cities = <CityModel>[];
  CityModel? currentCity;

  int selectedAddressIndex = 0;
  bool isDefaultAddressCheckBoxValue = false;
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  /// ------------ Controllers
  final TextEditingController streetNameController = TextEditingController();
  final TextEditingController houseNumberController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  /// ---------- FocusNodes
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode streetFocusNode = FocusNode();
  final FocusNode houseNumberFocusNode = FocusNode();
  final FocusNode countryFocusNode = FocusNode();
  final FocusNode cityFocusNode = FocusNode();
  final FocusNode stateFocusNode = FocusNode();
  final FocusNode zipCodeFocusNode = FocusNode();

  List<AddressModel> addresses = <AddressModel>[];

  /// ----------------------- Functions -------------------- ///

  /// Get the current detailed address as a list of Place Marks and get all saved addresses
  Future<void> init() async {
    /// to prevent show pinCode when service take time
    isLocalAuth = true;
    emit(ShippingLocationLoadLocation());
    try {
      await _getAddresses();
    } catch (e) {
      emit(ShippingLocationFailure());
    } finally {
      isLocalAuth = false;
    }
    countryFocusNode.addListener(() {
      if (countryFocusNode.hasFocus) {}
    });
  }

  // bool get enableButton {
  //   final bool isValid = globalKey.currentState?.validate() ?? true;
  //   if (isValid &&
  //       currentCity != null &&
  //       sl<BeneficiaryCubit>().currentCountry != null) {
  //     return true;
  //   }
  //   return false;
  // }

  void updateScreen() {
    emit(ShippingLocationUpdateScreen());
  }

  void changeDefaultAddress({required bool value}) {
    isDefaultAddressCheckBoxValue = value;
    emit(ShippingLocationChangeCheckBoxValue());
  }

  void changeCity({required CityModel cityModel}) {
    currentCity = cityModel;
    emit(ShippingLocationChangeCity());
  }

  Future<void> determineAddressDetails() async {
    emit(ShippingLocationCurrentPositionLoad());

    final Position? position = await _determinePosition();
    if (position != null) {
      final List<Placemark> placeMark =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      final Placemark firstLocation = placeMark.first;
      streetNameController.text = firstLocation.street ?? "";
      houseNumberController.text = firstLocation.name ?? "";
      cityController.text =
          firstLocation.administrativeArea?.split(' ')[0] ?? "";
      stateController.text = firstLocation.locality ?? "";
      postalCodeController.text = firstLocation.postalCode ?? "";
      countryController.text = firstLocation.country ?? "";
      phoneNumberController.text =
          await sl<LocalStorageService>().readSecureKey(userPhone) ?? "";
    }

    emit(ShippingLocationCurrentPositionLoaded());
  }

  /// Get the latitude and longitude of the current position
  /// part of [init] function
  Future<Position?> _determinePosition() async {
    late Position? position;
    try {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        return null;
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      position = await Geolocator.getCurrentPosition();
    } catch (e) {
      position = null;
    }

    return position;
  }

  Future<void> changeSelectedAddress(int index) async {
    selectedAddressIndex = index;
    emit(ShippingLocationChangeAddress());
  }

  Future<void> deleteAddress(int index) async {
    (await _shippingLocationRepository.deleteAddressesRepository(
            addressUUID: addresses[index].uuid!))
        .fold((Failure l) {
      emit(ShippingLocationFailure());
    }, (Map<String, dynamic> response) async {
      addresses.removeAt(index);

      /// if the selected address is the address that deleted make the selected address the first one
      if (selectedAddressIndex == index) {
        selectedAddressIndex = 0;
      }
      if (selectedAddressIndex > index) {
        selectedAddressIndex = selectedAddressIndex - 1;
      }
    });
    emit(ShippingLocationDeleteAddress());
  }

  Future<void> updateAddress() async {
    emit(ShippingLocationUpdateAddress());
    try {
      final Either<Failure, Map<String, dynamic>> either =
          await _shippingLocationRepository.updateAddressRepository(
              addressUUID: addresses[selectedAddressIndex].uuid!,
              isDefault: addresses[selectedAddressIndex].isDefault! ? 0 : 1);
      either.fold((Failure l) async {
        /// TODO: Refactor
        MyToast(tr('something_went_wrong'));
        emit(ShippingLocationFailure());
      }, (Map<String, dynamic> response) async {
        MyToast(tr('address_updated_successfully'));
        emit(ShippingLocationAddressUpdated());
      });
    } catch (e) {
      MyToast(tr('something_went_wrong'));
      emit(ShippingLocationFailure());
    }
  }

  /// Part of [init]
  Future<void> _getAddresses() async {
    (await _shippingLocationRepository.getAddressesRepository()).fold(
        (Failure l) {
      emit(ShippingLocationFailure());
    }, (List<AddressModel> response) async {
      addresses = response;
      selectedAddressIndex =
          response.indexWhere((AddressModel element) => element.isDefault!);
      selectedAddressIndex =
          selectedAddressIndex == -1 ? 0 : selectedAddressIndex;
    });

    emit(ShippingLocationGetAddressesLoaded());
  }

  /// Submit Add New Address
  Future<bool> addAddress(
      {required String countryUUID, required String cityUUID}) async {
    emit(ShippingLocationAddAddressLoad());
    try {
      (await _shippingLocationRepository.addAddressesRepository(
              phoneNumber: phoneNumberController.text.trim(),
              countryUUID: countryUUID,
              cityUUID: cityUUID,
              apartment: houseNumberController.text.trim(),
              zipCode: postalCodeController.text.trim(),
              isDefault: isDefaultAddressCheckBoxValue ? 1 : 0,
              streetName: streetNameController.text.trim(),
              state: stateController.text.trim()))
          .fold((Failure l) {
        emit(ShippingLocationFailure());
        return false;
      }, (AddressModel addressModel) {
        addresses.add(addressModel);
        if (addresses[addresses.length - 1].isDefault!) {
          selectedAddressIndex = addresses.length - 1;
        }
      });
    } catch (e) {
      emit(ShippingLocationFailure());
    }
    emit(ShippingLocationAddAddressLoaded());
    return true;
  }

  String? _compareCountryUUID;

  Future<void> getCities(String countryUUID) async {
    if (_compareCountryUUID == null || countryUUID != _compareCountryUUID) {
      emit(ShippingLocationCitiesLoading());

      try {
        (await _shippingLocationRepository.getCitiesByCountry(countryUUID))
            .fold((Failure l) {
          emit(ShippingLocationFailure());
        }, (List<ParentModel> r) {
          cities = r as List<CityModel>;
          currentCity = null;
          emit(ShippingLocationCitiesLoaded());
        });
      } catch (e) {
        emit(ShippingLocationFailure());
      }
    }
    _compareCountryUUID = countryUUID;
  }
}
