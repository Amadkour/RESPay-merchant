import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/provider/api/deposit_api.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/provider/model/create_deposit_input.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

class DepositRepo {
  final DepositRemoteApi _api;

  DepositRepo(this._api);

  Future<Either<Failure, ReceiptModel>> create(CreateDepositInput input) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> result =
          await _api.createDeposit(input);
      return result.fold(
        (Failure l) => left(l),
        (Response<Map<String, dynamic>> r) {
          return right(ReceiptModel.fromJson(
              r.data!['data'] as Map<String, dynamic>, 'deposit'));
        },
      );
    } catch (e) {
      return left(GeneralFailure(
        errors: <String, String>{'': e.toString()},
      ));
    }
  }
}
