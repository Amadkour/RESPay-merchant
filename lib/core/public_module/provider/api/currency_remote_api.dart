import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/currency_base_api.dart';

import 'package:res_pay_merchant/core/public_module/provider/end_point.dart';

class CurrencyRemoteApi extends CurrencyBaseApi {
  final APIConnection _connection = APIConnection.instance;

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> getCountries() async {
    try {
      final Response<Map<String, dynamic>> response = await _connection.dio.get(
        getCountryEndPoint,
      );

      final Map<String, dynamic>? body = response.data;

      if (body?['success'] == true) {
        return right(response);
      } else {
        return left(ApiFailure(
          errors: body?['errors'] as Map<String, dynamic>?,
        ));
      }
    } on SocketException {
      return left(NetworkFailure());
    } on DioError catch (e) {
      return left(ApiFailure(
        errors: <String, String>{'': e.message},
      ));
    }
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>>
      getCurrencies() async {
    try {
      final Response<Map<String, dynamic>> response = await _connection.dio.get(
        getCurrencyEndPoint,
      );

      final Map<String, dynamic>? body = response.data;

      if (body?['success'] == true) {
        return right(response);
      } else {
        return left(ApiFailure(
          errors: body?['errors'] as Map<String, dynamic>?,
        ));
      }
    } on SocketException {
      return left(NetworkFailure());
    } on DioError catch (e) {
      return left(ApiFailure(
        errors: <String, String>{'': e.message},
      ));
    }
  }

}
