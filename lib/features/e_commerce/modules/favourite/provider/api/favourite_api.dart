import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/api/end_points.dart';

class FavouriteApi {
  APIConnection apiConnection = APIConnection.instance;

  FavouriteApi({APIConnection? apiConnect}) {
    if (apiConnect != null) {
      apiConnection = apiConnect;
    } else {
      apiConnection = APIConnection.instance;
    }
    dio = apiConnection.dio;
  }
  late Dio dio;
  FavouriteApi.withDio({Dio? dio}) {
    this.dio = dio!;
  }
  FavouriteApi._singleTone();

  static final FavouriteApi _instance = FavouriteApi._singleTone();

  static FavouriteApi get instance => _instance;

  Future<Either<Failure, Response<Map<String, dynamic>>>> addProductToFavourite(String productUUID) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.post(
        data: FormData.fromMap(<String, dynamic>{
          "product_uuid": productUUID,
        }),
        addToFavouriteEndPoint,
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

  Future<Either<Failure, Response<Map<String, dynamic>>>> deleteProductFromFavourite(
      {required String favouriteUUID, required String productUUID}) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.post(
        data: FormData.fromMap(<String, dynamic>{"favorite_uuid": favouriteUUID, "product_uuid": productUUID}),
        deleteFavouriteProductsEndPoint,
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

  Future<Either<Failure, Response<Map<String, dynamic>>>> getFavouriteProducts() async {
    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        getFavouriteProductsEndPoint,
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
