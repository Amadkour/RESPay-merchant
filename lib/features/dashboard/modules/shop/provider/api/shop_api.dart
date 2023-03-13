import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/provider/end_points.dart';

class ShopApi {
  APIConnection apiConnection = APIConnection.instance;

  ShopApi({APIConnection? apiConnect}) {
    if (apiConnect != null) {
      apiConnection = apiConnect;
    } else {
      apiConnection = APIConnection.instance;
    }
  }

  ShopApi._singleTone();

  static final ShopApi _instance = ShopApi._singleTone();

  static ShopApi get instance => _instance;

  Future<Either<Failure, Response<Map<String, dynamic>>>> getShops() async {
    try {
      final Response<Map<String, dynamic>> response = await apiConnection.dio.get(
        shopsEndPoint,
      );

      final Map<String, dynamic>? body = response.data;
      if (body!['success'] == true) {
        return right(response);
      } else {
        return left(ApiFailure(
          errors: body['errors'] as Map<String,String>,
        ));
      }
    } on SocketException {
      return left(
        NetworkFailure(),
      );
    } on DioError {
      return left(ApiFailure());
    }
  }
}
