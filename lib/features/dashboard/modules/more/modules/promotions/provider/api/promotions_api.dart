import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/api/end_points.dart';

class PromotionsApi {
  APIConnection apiConnection = APIConnection.instance;

  PromotionsApi({APIConnection? apiConnect}) {
    if (apiConnect != null) {
      apiConnection = apiConnect;
    } else {
      apiConnection = APIConnection.instance;
    }
    dio = apiConnection.dio;
  }

  late Dio dio;

  PromotionsApi.withDio({Dio? dio}) {
    this.dio = dio!;
  }

  PromotionsApi._singleTone();

  static final PromotionsApi _instance = PromotionsApi._singleTone();

  static PromotionsApi get instance => _instance;

  Future<Either<Failure, Response<Map<String, dynamic>>>> getPromotions() async {
    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        getPromotionsEndPoint,
      );
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } on SocketException {
      return left(
        NetworkFailure(),
      );
    } on DioError catch (e) {
      return left(ApiFailure(
        errors: <String, String>{'': e.message},
      ));
    }
  }
}
