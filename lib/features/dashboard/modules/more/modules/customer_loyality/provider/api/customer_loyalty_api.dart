import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/end_point.dart';

class CustomerLoyaltyApi {
  late Dio _dio;

  CustomerLoyaltyApi([Dio? dio]) {
    _dio = dio ?? APIConnection.instance.dio;
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>> getLoyalties() async {
    try {
      //TODO remove in production
      final Response<Map<String, dynamic>> response = await _dio.get(
        getCustomerLoyaltyListApi,
      );

      final Map<String, dynamic>? body = response.data;

      if (body?['success'] == true) {
        return right(response);
      } else {
        return left(ApiFailure(
          errors: body?['errors'] as Map<String, dynamic>,
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

  Future<Either<Failure, Response<Map<String, dynamic>>>> show(String uuid) async {
    try {
      //TODO remove in production
      final Response<Map<String, dynamic>> response =
          await _dio.get(showCustomerLoyaltyApi, queryParameters: <String, dynamic>{
        "shop_uuid": uuid,
      });

      final Map<String, dynamic>? body = response.data;

      if (body?['success'] == true) {
        return right(response);
      } else {
        return left(ApiFailure(
          errors: body?['errors'] as Map<String, dynamic>,
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

  Future<Either<Failure, Response<Map<String, dynamic>>>> redeem(String uuid) async {
    try {
      //TODO remove in production

      final Response<Map<String, dynamic>> response = await _dio.post(customerLoyaltyRedeemApi,
          data: FormData.fromMap(<String, dynamic>{
            "shop_uuid": uuid,
          }));

      final Map<String, dynamic>? body = response.data;

      if (body?['success'] == true) {
        return right(response);
      } else {
        return left(ApiFailure(
          errors: body?['errors'] as Map<String, dynamic>
        ));
      }
    } on SocketException {
      return left(NetworkFailure());
    } on DioError catch (e) {
      return left(ApiFailure(
        errors:<String,String>{'': e.message},
      ));
    }
  }
}
