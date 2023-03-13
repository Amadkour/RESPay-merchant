import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';

import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/api/base_orders_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/end_point.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/complain_order_inputs.dart';

class RemoteOrdersApi extends BaseOrdersApi {
  late Dio _dio;

  RemoteOrdersApi({Dio? dio}) {
    _dio = dio ?? APIConnection.instance.dio;
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> getOrders() async {
    try {
      //TODO remove in production

      final Response<Map<String, dynamic>> response = await _dio.get(
        getOrderListApi,
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

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> trackOrder(String uuid) async {
    try {
      //TODO remove in production

      final Response<Map<String, dynamic>> response = await _dio.post(trackOrderApi,
          data: FormData.fromMap(<String, dynamic>{
            "order_uuid": uuid,
          }));

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

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> buyAgain(String uuid) async {
    try {
      //TODO remove in production

      final Response<Map<String, dynamic>> response = await _dio.post(buyOrderAgain,
          data: FormData.fromMap(<String, dynamic>{
            "order_uuid": uuid,
          }));

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

  @override
  Future<Option<Failure>> cancelOrder({required String description, required String orderUUID}) async {
    try {
      //TODO remove in production

      final Response<Map<String, dynamic>> response = await _dio.post(cancelOrderApi,
          data: FormData.fromMap(
            <String, dynamic>{
              "order_uuid": orderUUID,
              "user_uuid": loggedInUser.uuid,
              "description": description,
            },
          ));

      final Map<String, dynamic>? body = response.data;

      if (body?['success'] == true) {
        return none();
      } else {
        return some(ApiFailure(
          errors: body?['errors'] as Map<String, dynamic>,
        ));
      }
    } on SocketException {
      return some(NetworkFailure());
    } on DioError catch (e) {
      return some(ApiFailure(
        errors: <String, String>{'': e.message},
      ));
    }
  }

  @override
  Future<Option<Failure>> complainOrder(ComplainOrderInput inputs) async {
    try {
      //TODO remove in production

      log(inputs.toMap().toString());

      final Response<Map<String, dynamic>> response =
          await _dio.post(complainOrderApi, data: FormData.fromMap(inputs.toMap()));

      final Map<String, dynamic>? body = response.data;

      if (body?['success'] == true) {
        return none();
      } else {
        return some(ApiFailure(
          errors: body?['errors'] as Map<String, dynamic>,
        ));
      }
    } on SocketException {
      return some(NetworkFailure());
    } on DioError catch (e) {
      return some(ApiFailure(
        errors: <String, String>{'': e.message},
      ));
    }
  }
}
