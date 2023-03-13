import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/core/public_module/provider/end_point.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/API/end_point.dart';

class ShippingLocationAPI {
  late Dio _dio;

  ShippingLocationAPI({Dio? dio}) {
    _dio = dio ?? APIConnection.instance.dio;
  }

  ShippingLocationAPI._singleTone() {
    _dio = APIConnection.instance.dio;
  }

  static final ShippingLocationAPI _instance =
      ShippingLocationAPI._singleTone();

  static ShippingLocationAPI get instance => _instance;

  /// get address API
  Future<Either<Failure, Response<Map<String, dynamic>>>> getAddresses() async {
    late Response<Map<String, dynamic>> response;

    try {

      /// Calling API
      response = await _dio.get(
        getAddressesPath,
      );

      /// Success (Successful Request)
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      /// Failed (API Crashed)
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(

          code: response.statusCode,
          resourceName: 'getAddresses_api_line_44',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }

  /// delete address API
  Future<Either<Failure, Response<Map<String, dynamic>>>> deleteAddress(
      {required String addressUUID}) async {
    late Response<Map<String, dynamic>> response;

    try {
      final FormData formData =
          FormData.fromMap(<String, String>{'address_uuid': addressUUID});

      /// Calling API
      response = await _dio.post(deleteAddressesPath, data: formData);

      /// Success (Successful Request)
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      /// Failed (API Crashed)
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(

          code: response.statusCode,
          resourceName: 'deleteAddresses_api_line_71',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }

  /// update address API (just for update )
  Future<Either<Failure, Response<Map<String, dynamic>>>> updateAddress(
      {required String addressUUID, required int isDefault}) async {
    late Response<Map<String, dynamic>> response;

    try {
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'address_uuid': addressUUID,
        'is_default': isDefault
      });

      /// Calling API
      response = await _dio.post(updateAddressesPath, data: formData);

      /// Success (Successful Request)
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      /// Failed (API Crashed)
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(

          code: response.statusCode,
          resourceName: 'deleteAddresses_api_line_71',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }

  /// add address API
  Future<Either<Failure, Response<Map<String, dynamic>>>> addAddress({
    required String phoneNumber,
    required String countryUUID,
    required String cityUUID,
    required String apartment,
    required String zipCode,
    required int isDefault,
    required String streetName,
    required String state,
  }) async {
    late Response<Map<String, dynamic>> response;

    try {
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'phone_number': phoneNumber,
        'country_uuid': countryUUID,
        'city_uuid': cityUUID,
        'apartment': apartment,
        'zip_code': zipCode,
        'is_default': isDefault,
        'street_name': streetName,
        'state': state,
      });

      /// Calling API
      response = await _dio.post(addAddressesPath, data: formData);

      /// Success (Successful Request)
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      /// Failed (API Crashed)
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(

          code: response.statusCode,
          resourceName: 'addAddress_api_line_114',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>> getCitiesByCountry(
      String countryUUID) async {
    try {
      //TODO remove in production
      final Response<Map<String, dynamic>> response = await APIConnection
          .instance.dio
          .get(getCitiesEndPoint, queryParameters: <String, String>{
        // 'country_uuid': countryUUID ?? 'b2af5534-450b-3d4f-9797-4564a982996b'
        'country_uuid': countryUUID
      });

      final Map<String, dynamic>? body = response.data;

      if (body?['success'] == true) {
        return Right<Failure, Response<Map<String, dynamic>>>(response);
      } else {
        return left(ApiFailure(
          errors: body?['errors'] as Map<String,dynamic>,
        ));
      }
    } on SocketException {
      return left(NetworkFailure());
    } on DioError catch (e) {
      return left(ApiFailure(
        errors: <String,String>{'':e.message},
      ));
    }
  }
}
