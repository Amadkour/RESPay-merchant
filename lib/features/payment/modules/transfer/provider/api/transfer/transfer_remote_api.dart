import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/end_point.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/transfer/transfer_base_api.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer_create_input.dart';

class TransferRemoteApi extends TransferBaseApi {
  late Dio dio;

  TransferRemoteApi({Dio? dio}) {
    this.dio = dio ?? APIConnection.instance.dio;
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> createTransfer(
      CreateTransferInput input) async {
    try {
      //TODO remove in production
      final Response<Map<String, dynamic>> response = await dio.post(
        createTransferApi,
        data: input.toMap(),
      );
      final Map<String, dynamic>? body = response.data;
      if (body!['success'] == true) {
        return right(response);
      } else {
        final Map<String, dynamic>? errors =
            body['errors'] as Map<String, dynamic>?;
        return left(ApiFailure(
          errors: errors != null ? Map<String, String>.from(errors) : null,
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
