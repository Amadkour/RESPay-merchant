import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/provider/api/base_analytics_api.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/provider/end_point.dart';

class RemoteAnalyticsApi extends BaseAnalyticsApi {
  late Dio _dio;

  RemoteAnalyticsApi([Dio? dio]) {
    _dio = dio ?? APIConnection.instance.dio;
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> get() async {
    try {
      final Response<Map<String, dynamic>> response = await _dio.get(
        getAnalyticsApi,
      );

      final Map<String, dynamic>? body = response.data;

      if (body?['success'] == true) {
        return right(response);
      } else {
        return left(ApiFailure(
          errors: body?['errors'] as Map<String,dynamic>,
        ));
      }
    } on SocketException {
      return left(
        NetworkFailure(),
      );
    } on DioError catch (e) {
      return left(ApiFailure(  errors: <String,String>{'':e.message},
      ));
    }
  }
}
