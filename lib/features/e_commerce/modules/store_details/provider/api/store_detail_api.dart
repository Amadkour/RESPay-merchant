import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/provider/api/end_points.dart';

class StoreDetailApi {
  APIConnection apiConnection = APIConnection.instance;

  StoreDetailApi({APIConnection? apiConnect}) {
    if (apiConnect != null) {
      apiConnection = apiConnect;
    } else {
      apiConnection = APIConnection.instance;
    }
    dio = apiConnection.dio;
  }
  late Dio dio;
  StoreDetailApi.withDio({Dio? dio}) {
    this.dio = dio!;
  }

  StoreDetailApi._singleTone();

  static final StoreDetailApi _instance = StoreDetailApi._singleTone();

  static StoreDetailApi get instance => _instance;

  Future<Either<Failure, Response<Map<String, dynamic>>>> getSingleShop(String slug) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        "$singleShopEndPoint/$slug",
      );

      final Map<String, dynamic>? body = response.data;
      if (body!['success'] == true) {
        return right(response);
      } else {
        return left(ApiFailure(
          errors: body['errors'] as Map<String, dynamic>,
        ));
      }
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
