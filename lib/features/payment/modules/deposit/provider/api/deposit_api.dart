import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/provider/end_points.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/provider/model/create_deposit_input.dart';

class DepositRemoteApi {
  late Dio _dio;
  DepositRemoteApi({Dio? dio}) {
    _dio = dio ?? APIConnection.instance.dio;
  }
  Future<Either<Failure, Response<Map<String, dynamic>>>> createDeposit(
      CreateDepositInput input) async {
    try {
      //TODO remove in production
      final Response<Map<String, dynamic>> response = await _dio.post(
        createDepositEndPoint,
        data: input.toMap(),
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
