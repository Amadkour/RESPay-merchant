import 'dart:io';

import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/exceptions.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';

import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/API/end_points.dart';
import 'package:res_pay_merchant/features/payment/modules/add_card/api/model/create_card_input.dart';

class CardsAPI {
  late Dio dio;

  CardsAPI({Dio? dio}) {
    this.dio = dio!;
  }

  CardsAPI._singleTone() {
    dio = APIConnection.instance.dio;
  }

  static final CardsAPI _instance = CardsAPI._singleTone();

  static CardsAPI get instance => _instance;

  Future<Map<String, dynamic>> getCreditCards() async {
    try {
      final Response<dynamic> response = await dio.get(gerCreditCards);
      final Map<String, dynamic> body = response.data as Map<String, dynamic>;

      if (body['success'] == true) {
        return body['data'] as Map<String, dynamic>;
      } else {
        throw ServerException(
            message: body['hint'] as String,
            statusCode: response.statusCode ?? 500);
      }
    } on SocketException {
      throw NoInternetException();
    } on DioError catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  Future<Map<String, dynamic>> getPaymentMethods() async {
    try {
      //TODO remove in production
      final Response<dynamic> response = await dio.get(
        getPaymentMethodsApi,
      );

      final Map<String, dynamic> body = response.data as Map<String, dynamic>;

      if (body['success'] == true) {
        return body['data'] as Map<String, dynamic>;
      } else {
        throw ServerException(
            message: body['hint'] as String,
            statusCode: response.statusCode ?? 500);
      }
    } on SocketException {
      throw NoInternetException();
    } on DioError catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  Future<bool> createCard(CreateCardInput input) async {
    try {
      //TODO remove in production
      final Response<dynamic> response = await dio.post(
        createCreditCardApi,
        data: input.toFormData(),
      );

      final Map<String, dynamic> body = response.data as Map<String, dynamic>;

      if (body['success'] == true) {
        return true;
      } else {
        final Map<String, dynamic> errors =
            body['errors'] as Map<String, dynamic>;
        throw ServerException(
          errors: errors,
          message: body['hint'] as String,
          statusCode: response.statusCode ?? 500,
        );
      }
    } on SocketException {
      throw NoInternetException();
    } on DioError catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }

  Future<bool> deleteCard(String uuid) async {
    try {
      //TODO remove in production
      final Response<dynamic> response = await dio.post(
        deleteCreditCardApi,
        data: <String, dynamic>{
          "card_uuid": uuid,
        },
      );

      final Map<String, dynamic> body = response.data as Map<String, dynamic>;

      if (body['success'] == true) {
        return true;
      } else {
        throw ServerException(
            message: body['hint'] as String,
            statusCode: response.statusCode ?? 500);
      }
    } on SocketException {
      throw NoInternetException();
    } on DioError catch (e) {
      throw ServerException(
        message: e.message,
        statusCode: e.response?.statusCode ?? 500,
      );
    }
  }
}
