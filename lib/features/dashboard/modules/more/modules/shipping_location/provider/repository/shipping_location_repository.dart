import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/API/shipping_location_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/model/address_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/model/city_model.dart';

class ShippingLocationRepository {
  late ShippingLocationAPI _shippingLocationAPI;

  ShippingLocationRepository({ShippingLocationAPI? shippingLocationAPI}) {
    _shippingLocationAPI = shippingLocationAPI ?? ShippingLocationAPI.instance;
  }

  ShippingLocationRepository._singleTone() {
    _shippingLocationAPI = ShippingLocationAPI.instance;
  }

  static final ShippingLocationRepository _instance =
      ShippingLocationRepository._singleTone();

  static ShippingLocationRepository get instance => _instance;

  /// [Get] addresses
  Future<Either<Failure, List<AddressModel>>> getAddressesRepository() async {
    try {
      /// --------------------------- Calling API Function ------------------------ ///
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await _shippingLocationAPI.getAddresses();

      return res.fold((Failure l) => Left<Failure, List<AddressModel>>(l),
          (Response<dynamic> response) {
        if (response.statusCode != 200 ||
            !((response.data as Map<String, dynamic>?)!['success'] as bool)) {
          /// Failure Response
          return Left<Failure, List<AddressModel>>(ApiFailure(
              // message: ((response.data as Map<String, dynamic>?)!['hint']
              //         as String?) ??
              //     ((response.data as Map<String, dynamic>?)!['error'])
              //         .toString(),
              code: response.statusCode,
              resourceName: 'getAddressesRepository_line_40',
              errors: ((response.data as Map<String, dynamic>?)!['errors']
                      as Map<String, dynamic>?) ??
                  <String, String>{}));
        } else {
          /// Success
          return Right<Failure, List<AddressModel>>((((response.data
                      as Map<String, dynamic>)['data']
                  as Map<String, dynamic>)['addresses'] as List<dynamic>)
              .map((dynamic e) =>
                  AddressModel().fromJsonInstance(e as Map<String, dynamic>))
              .toList());
        }
      });
    } on Exception catch (e) {
      /// Repository Crashed
      return Left<Failure, List<AddressModel>>(ApiFailure(
        errors: <String,String>{'':e.toString()},
        code: 404,
        resourceName: 'getAddressesRepository_line_59',
      ));
    }
  }

  /// [Delete] addresses
  Future<Either<Failure, Map<String, dynamic>>> deleteAddressesRepository(
      {required String addressUUID}) async {
    try {
      /// --------------------------- Calling API Function ------------------------ ///
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await _shippingLocationAPI.deleteAddress(addressUUID: addressUUID);

      return res.fold((Failure l) => Left<Failure, Map<String, dynamic>>(l),
          (Response<dynamic> response) {
        if (response.statusCode != 200 ||
            !((response.data as Map<String, dynamic>?)!['success'] as bool)) {
          /// Failure Response
          return Left<Failure, Map<String, dynamic>>(ApiFailure(

              code: response.statusCode,
              resourceName: 'deleteAddressesRepository_line_82',
              errors: ((response.data as Map<String, dynamic>?)!['errors']
                      as Map<String, dynamic>?) ??
                  <String, String>{}));
        } else {
          /// Success
          return Right<Failure, Map<String, dynamic>>(
              response.data as Map<String, dynamic>);
        }
      });
    } on Exception catch (e) {
      /// Repository Crashed
      return Left<Failure, Map<String, dynamic>>(ApiFailure(
        errors: <String,String>{'':e.toString()},
        code: 404,
        resourceName: 'deleteAddressesRepository_line_101',
      ));
    }
  }

  /// [Update] addresses
  Future<Either<Failure, Map<String, dynamic>>> updateAddressRepository(
      {required String addressUUID,required int isDefault}) async {
    try {
      /// --------------------------- Calling API Function ------------------------ ///
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await _shippingLocationAPI.updateAddress(addressUUID: addressUUID,isDefault: isDefault);

      return res.fold((Failure l) => Left<Failure, Map<String, dynamic>>(l),
          (Response<dynamic> response) {
        if (response.statusCode != 200 ||
            !((response.data as Map<String, dynamic>?)!['success'] as bool)) {
          /// Failure Response
          return Left<Failure, Map<String, dynamic>>(ApiFailure(

              code: response.statusCode,
              resourceName: 'deleteAddressesRepository_line_82',
              errors: ((response.data as Map<String, dynamic>?)!['errors']
                      as Map<String, dynamic>?) ??
                  <String, String>{}));
        } else {
          /// Success
          return Right<Failure, Map<String, dynamic>>(
              response.data as Map<String, dynamic>);
        }
      });
    } on Exception catch (e) {
      /// Repository Crashed
      return Left<Failure, Map<String, dynamic>>(ApiFailure(
        errors: <String,String>{'':e.toString()},
        code: 404,
        resourceName: 'deleteAddressesRepository_line_101',
      ));
    }
  }

  /// [Create] addresses
  Future<Either<Failure, AddressModel>> addAddressesRepository({
    required String phoneNumber,
    required String countryUUID,
    required String cityUUID,
    required String apartment,
    required String zipCode,
    required int isDefault,
    required String streetName,
    required String state,
  }) async {
    try {
      /// --------------------------- Calling API Function ------------------------ ///
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await _shippingLocationAPI.addAddress(
              phoneNumber: phoneNumber,
              countryUUID: countryUUID,
              cityUUID: cityUUID,
              apartment: apartment,
              zipCode: zipCode,
              isDefault: isDefault,
              streetName: streetName,
              state: state);

      return res.fold((Failure l) => Left<Failure, AddressModel>(l),
          (Response<dynamic> response) {
        if (response.statusCode != 201 ||
            !((response.data as Map<String, dynamic>?)!['success'] as bool)) {
          /// Failure Response
          return Left<Failure, AddressModel>(ApiFailure(

              code: response.statusCode,
              resourceName: 'addAddressesRepository_line_139',
              errors: ((response.data as Map<String, dynamic>?)!['errors']
                      as Map<String, dynamic>?) ??
                  <String, String>{}));
        } else {
          /// Success
          return Right<Failure, AddressModel>(
            AddressModel().fromJsonInstance(((response.data
                    as Map<String, dynamic>)['data']
                as Map<String, dynamic>)['address'] as Map<String, dynamic>),
          );
        }
      });
    } on Exception catch (e) {
      /// Repository Crashed
      return Left<Failure, AddressModel>(ApiFailure(
        errors: <String,String>{'':e.toString()},
        code: 404,
        resourceName: 'addAddressesRepository_line_154',
      ));
    }
  }

  Future<Either<Failure, List<ParentModel>>> getCitiesByCountry(
      String countryUUID) async {
    try {
      /// --------------------------- Calling API Function ------------------------ ///
      final Either<Failure, Response<dynamic>> res =
          await _shippingLocationAPI.getCitiesByCountry(countryUUID);

      return res.fold((Failure l) => Left<Failure, List<ParentModel>>(l),
          (Response<dynamic> response) {
        if (response.statusCode != 200 ||
            !((response.data as Map<String, dynamic>?)!['success'] as bool)) {
          /// Failure Response
          return Left<Failure, List<ParentModel>>(ApiFailure(

              code: response.statusCode,
              resourceName: 'Registration_repository_line_35',
              errors: ((response.data as Map<String, dynamic>?)!['errors']
                      as Map<String, dynamic>?) ??
                  <String, String>{}));
        } else {
          /// Success
          return Right<Failure, List<ParentModel>>(
              (((response.data as Map<String, dynamic>?)!['data']
                      as Map<String, dynamic>)['cities'] as List<dynamic>)
                  .map((dynamic e) =>
                      CityModel().fromJsonInstance(e as Map<String, dynamic>))
                  .toList());
        }
      });
    } on Exception catch (e) {
      /// Repository Crashed
      return Left<Failure, List<ParentModel>>(ApiFailure(
        errors: <String,String>{'':e.toString()},
        code: 404,
        resourceName: 'ForgetPassword_repository_line_50',
      ));
    }
  }
}
