import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/transfer/transfer_base_api.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer_create_input.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

class TransferRepo {
  final TransferBaseApi _api;

  TransferRepo(this._api);
  Future<Either<Failure, ReceiptModel>> create(
      CreateTransferInput input) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> result =
          await _api.createTransfer(input);
      return result.fold((Failure l) => left(l),
          (Response<Map<String, dynamic>> r) {
        return right(
          ReceiptModel.fromJson(
              r.data!['data'] as Map<String, dynamic>, "transfer"),
        );
      });
    } catch (e) {
      return left(GeneralFailure(
        errors: <String, String>{'': e.toString()},
      ));
    }
  }
}
