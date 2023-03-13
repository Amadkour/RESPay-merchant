import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/provider/api/add_bank_api.dart';

class AddBankRepo {
  Future<Option<Failure>> createAccount({
    required String iBan,
    required String accountNum,
    required String ownerName,
  }) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await AddBankApi.instance.addBankAccount(
        iban: iBan,
        accountNum: accountNum,
        ownerName: ownerName,
      );

      return res.fold((Failure l) => some(l),
          (Response<Map<String, dynamic>> response) {
        if (response.statusCode != 201 ||
            !(response.data!['success'] as bool)) {
          return some(
            ApiFailure(
                code: response.statusCode,
                resourceName: 'pay_bill_repository_line_55',
                errors: (response.data!['errors'] ?? <String, dynamic>{})
                    as Map<String, dynamic>),
          );
        } else {
          return none();
        }
      });
    } on Exception catch (e) {
      return some(
        ApiFailure(
          errors: <String, String>{'': e.toString()},
          code: 404,
          resourceName: 'create_account_repository_line_65',
        ),
      );
    }
  }
}
