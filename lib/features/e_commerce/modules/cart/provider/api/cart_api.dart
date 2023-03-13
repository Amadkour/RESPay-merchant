import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/api/end_points.dart';

class CartApi {
  APIConnection apiConnection = APIConnection.instance;

  CartApi({APIConnection? apiConnect}) {
    if (apiConnect != null) {
      apiConnection = apiConnect;
    } else {
      apiConnection = APIConnection.instance;
    }
    dio = apiConnection.dio;
  }
  late Dio dio;
  CartApi.withDio({Dio? dio}) {
    this.dio = dio!;
  }
  CartApi._singleTone();

  static final CartApi _instance = CartApi._singleTone();

  static CartApi get instance => _instance;

  Future<Either<Failure, Response<Map<String, dynamic>>>> addProductToCart(String productUUID,String cartUUID) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.post(
        data: FormData.fromMap(<String, dynamic>{
          "product_uuid": productUUID,
          "quantity": 1,
        }),
        addToCartEndPoint,
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

  Future<Either<Failure, Response<Map<String, dynamic>>>> updateProductInCart(String itemKey, int quantity,String cartUUID) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.post(
        data: FormData.fromMap(<String, dynamic>{
          "item_uuid": itemKey,
          "cart_uuid":cartUUID,
          "quantity": quantity,
        }),
        updateCartProductsEndPoint,
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

  Future<Either<Failure, Response<Map<String, dynamic>>>> deleteProductFromCart(String itemKey,String cartUUID) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.post(
        data: FormData.fromMap(<String, dynamic>{
          "item_uuid": itemKey,
          "cart_uuid":cartUUID,
        }),
        deleteCartProductsEndPoint,
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

  Future<Either<Failure, Response<Map<String, dynamic>>>> getCartProducts(String shopUUID) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.get(
        getCartProductsEndPoint,
        queryParameters:  <String,dynamic>{
          "shop_uuid":shopUUID
        }
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

  Future<Either<Failure, Response<Map<String, dynamic>>>> checkPromotion(String promoCode) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.post(
        data: FormData.fromMap(<String, dynamic>{
          "code": promoCode,
        }),
        checkPromotionEndPoint,
      );
      if (response.data!['success'] == true) {
        return Right<Failure, Response<Map<String, dynamic>>>(response);
      } else {
        return left(ApiFailure(
          errors: response.data!['errors'] as Map<String, dynamic>,
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

  Future<Either<Failure, Response<Map<String, dynamic>>>> removePromotion(String promoCode) async {
    try {
      final Response<Map<String, dynamic>> response = await dio.post(
        data: FormData.fromMap(<String, dynamic>{
          "code": promoCode,
        }),
        removePromotionEndPoint,
      );
      if (response.data!['success'] == true) {
        return Right<Failure, Response<Map<String, dynamic>>>(response);
      } else {
        return left(ApiFailure(
          errors: response.data!['errors'] as Map<String, dynamic>,
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
