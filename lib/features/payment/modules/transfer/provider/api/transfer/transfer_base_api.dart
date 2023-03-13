import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer_create_input.dart';

abstract class TransferBaseApi {
  Future<Either<Failure, Response<Map<String, dynamic>>>> createTransfer(
      CreateTransferInput input);
}
