import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/API/end_point.dart';

class SavingAPI {
  late Dio _dio;
  SavingAPI({Dio? dio}) {
    _dio = dio ?? APIConnection.instance.dio;
  }

  SavingAPI._singleTone() {
    _dio = APIConnection.instance.dio;
  }

  static final SavingAPI _instance = SavingAPI._singleTone();

  static SavingAPI get instance => _instance;

  /// Get Saving List
  Future<Either<Failure, Response<Map<String, dynamic>>>> getSavings() async {
    late Response<Map<String, dynamic>> response;
    try {
      response = await _dio.get(getSavingListPath);
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'saving_list_line_37',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }

  /// Deposit
  Future<Either<Failure, Response<Map<String, dynamic>>>> addMoney(
      {required double amount}) async {
    late Response<Map<String, dynamic>> response;

    try {
      final FormData formData =
          FormData.fromMap(<String, dynamic>{'amount': amount});
      response = await _dio.post(addMoneyPath, data: formData);
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'add_money-saving_line_58',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }

  /// Withdraw
  Future<Either<Failure, Response<Map<String, dynamic>>>> withdraw(
      {required double amount}) async {
    late Response<Map<String, dynamic>> response;
    try {
      final FormData formData =
          FormData.fromMap(<String, dynamic>{'amount': amount});
      response = await _dio.post(withdrawPath, data: formData);
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'saving_withdraw_line_77',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }

  /// Toggle Activation Saving
  Future<Either<Failure, Response<Map<String, dynamic>>>> toggleSaving(
      String uuid) async {
    late Response<Map<String, dynamic>> response;

    try {
      final FormData formData =
          FormData.fromMap(<String, dynamic>{'user_uuid': uuid});
      response = await _dio.post(toggleSavingPath, data: formData);
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'toggle-saving_line_98',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }
}
