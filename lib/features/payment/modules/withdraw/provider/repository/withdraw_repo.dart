import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/provider/api/withdraw_api.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/provider/model/bank_account.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

class WithdrawRepository {
  late BankAccount data = BankAccount();

  Future<Either<Failure, ParentModel>> getBankAccount() async {
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse =
        await WithdrawApi.instance.getBankAccount();

    ///--------
    final ParentRepo<BankAccount> parentRepo =
        ParentRepo<BankAccount>(apiResponse, BankAccount());
    data = parentRepo.modelInstance as BankAccount;

    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  ///--------------------------Withdraw Repository
  Future<Either<Failure, ReceiptModel>> withdraw({
    String? amount,
    String? walletUUID,
    String? bankUuid,
  }) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await WithdrawApi.instance.withdrawOperation(
        amount: amount,
        walletUUID: walletUUID,
        bankAccountUUid: bankUuid,
      );

      return res.fold((Failure l) => left(l),
          (Response<Map<String, dynamic>> response) {
        if (response.statusCode != 200 ||
            !(response.data!['success'] as bool)) {
          return left(ApiFailure(
              code: response.statusCode,
              resourceName: 'withdraw_repository_line_55',
              errors: (response.data!['errors'] ?? <dynamic>{})
                  as Map<String, dynamic>));
        } else {
          return right(ReceiptModel.fromJson(
              response.data!['data'] as Map<String, dynamic>, 'withdraw'));
        }
      });
    } on Exception catch (e) {
      return left(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'withdraw_repository_line_65',
      ));
    }
  }
}
