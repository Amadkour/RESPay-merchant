import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/notification/provider/API/path.dart';

class NotificationAPI {
  NotificationAPI([Dio? dio]) {
    _dio = dio ?? APIConnection.instance.dio;
  }

  NotificationAPI._singleTone() {
    _dio = APIConnection.instance.dio;
  }

  static final NotificationAPI _instance = NotificationAPI._singleTone();

  static NotificationAPI get instance => _instance;

  late Dio _dio;

  Future<Either<Failure, Response<Map<String, dynamic>>>>
      getNotificationModel() async {
    try {
      final Response<Map<String, dynamic>> response = await _dio.get(
        notificationPath,
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
      return left(
        NetworkFailure(),
      );
    } on DioError catch (e) {
      return left(ApiFailure(
        errors: <String, String>{'': e.message},
      ));
    }
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>> readNotification({required String uuid,required String source}) async {
    try {
      final Response<Map<String, dynamic>> response = await _dio.post(
        data: FormData.fromMap({
          "uuid":uuid,
          "source":source
          }
        ),
        readNotificationPath,
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
      return left(
        NetworkFailure(),
      );
    } on DioError catch (e) {
      return left(ApiFailure(
        errors: <String, String>{'': e.message},
      ));
    }
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>> deleteNotification({required String uuid,
    required String source}) async {
    try {
      final Response<Map<String, dynamic>> response = await _dio.post(
        data: FormData.fromMap(<String,dynamic>{
          "uuid":uuid,
          "source":source
          }
        ),
        deleteNotificationPath,
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
