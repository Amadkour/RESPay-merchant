import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/controller/bank_name_controller/bank_name_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/provider/api/end_point.dart';

class AddBankApi {
  APIConnection apiConnection = APIConnection.instance;

  AddBankApi({APIConnection? apiConnect}) {
    if (apiConnect != null) {
      apiConnection = apiConnect;
    } else {
      apiConnection = APIConnection.instance;
    }
  }

  AddBankApi._singleTone();

  static final AddBankApi _instance = AddBankApi._singleTone();

  static AddBankApi get instance => _instance;

  ///---------------------------------- Add Bank Account

  Future<Either<Failure, Response<Map<String, dynamic>>>> addBankAccount({
    required String iban,
    required String accountNum,
    required String ownerName,
  }) async {
    // apiConnection.dio.options.baseUrl = 'https://finance.eightyythree.com/api/finance';

    apiConnection.showMessage = true;
    late Response<Map<String, dynamic>> response;
    try {
      response =
          await apiConnection.dio.post(createBankPath, data: <String, dynamic>{
        'bank_uuid': sl<BankNameCubit>().currentBankName!.uuid,
        'is_active': 1,
        'iban': iban,
        'account_number': accountNum,
        'account_name': ownerName
      });

      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'create_account_api_line_55',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }
}
