import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/end_point.dart';

class TransferOptionsRemoteApi {
  late Dio dio;

  TransferOptionsRemoteApi({Dio? dio}) {
    this.dio = dio ?? APIConnection.instance.dio;
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>> get() async {
    try {
      //TODO remove in production
      final Response<Map<String, dynamic>> response = await dio.get(
        loadTransferOptions,
      );
      final Map<String, dynamic>? body = response.data;
      if (body!['success'] == true) {
        return right(response);
      } else {
        return left(ApiFailure(
          errors: body['errors'] as Map<String, String>,
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
}
