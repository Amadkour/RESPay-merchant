import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/api/base_transaction_api.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/end_point.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/history_filter_input.dart';

class HistoryApi extends BaseTransactionApi {
  late Dio dio;

  HistoryApi({Dio? dio}) {
    this.dio = dio ?? APIConnection.instance.dio;
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> getWallet() async {
    try {
      //TODO remove in production
      final Response<Map<String, dynamic>> response = await dio.get(
        getWalletApi,
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
  Future<Either<Failure, Response<Map<String, dynamic>>>> getTransactions(
      {HistoryFilterInput? filters}) async {
    try {
      //TODO remove in production
      final Response<Map<String, dynamic>> response = await dio.get(
        getTransactionListApi,
        queryParameters: filters?.toMap(),
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
}
