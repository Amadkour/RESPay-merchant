import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/history_filter_input.dart';

abstract class BaseTransactionApi {
  Future<Either<Failure, Response<Map<String, dynamic>>>> getWallet();
  Future<Either<Failure, Response<Map<String, dynamic>>>> getTransactions(
      {HistoryFilterInput? filters});
}
