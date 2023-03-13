import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/provider/api/end_point.dart';

class WithdrawApi {
  APIConnection apiConnection = APIConnection.instance;

  WithdrawApi({APIConnection? apiConnect}) {
    if (apiConnect != null) {
      apiConnection = apiConnect;
    } else {
      apiConnection = APIConnection.instance;
    }
  }

  WithdrawApi._singleTone();

  static final WithdrawApi _instance = WithdrawApi._singleTone();

  static WithdrawApi get instance => _instance;

  ///---------------------------------- get Bank Account
  Future<Either<Failure, Response<Map<String, dynamic>>>>
      getBankAccount() async {
    apiConnection.showMessage = true;
    late Response<Map<String, dynamic>> response;

    // apiConnection.dio.options.baseUrl = 'https://finance.eightyythree.com/api/finance';
    try {
      response = await apiConnection.dio.get(bankAccountListPath,
          queryParameters: <String, dynamic>{"user_uuid": userUUID});

      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'banks_api_line_55',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }

  ///---------------------------------Withdraw operation

  Future<Either<Failure, Response<Map<String, dynamic>>>> withdrawOperation({
    String? amount,
    String? walletUUID,
    String? bankAccountUUid,
  }) async {
    // apiConnection.dio.options.baseUrl = 'https://wallet.eightyythree.com/api/wallet';
    apiConnection.showMessage = true;
    late Response<Map<String, dynamic>> response;

    try {
      response = await apiConnection.dio.post(withdrawPath,
          data: FormData.fromMap(<String, dynamic>{
            'amount': amount,
            'withdraw_method': 'bank_account',
            'wallet_uuid': walletUUID,
            'bank_account_uuid': bankAccountUUid
          }));
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'withdraw_api_line_67',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }
}
