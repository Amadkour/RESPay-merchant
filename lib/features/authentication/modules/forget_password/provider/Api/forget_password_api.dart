import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/Api/end_point.dart';

class ForgotPasswordAPI {
  late Dio _dio;

  /// ------------------------ Pass [Dio] To use it in testing ------------------------ ///
  ForgotPasswordAPI({Dio? dio}) {
    _dio = dio ?? APIConnection.instance.dio;
  }

  /// --------------------------- SingleTone API ------------------------ ///
  ForgotPasswordAPI._singleTone() {
    _dio = APIConnection.instance.dio;
  }

  static final ForgotPasswordAPI _instance = ForgotPasswordAPI._singleTone();

  static ForgotPasswordAPI get instance => _instance;

  /// Forgot password API
  Future<Either<Failure, Response<Map<String, dynamic>>>> forgotPassword(
      {required Map<String, String> identifier}) async {
    late Response<Map<String, dynamic>> response;

    try {
      /// Calling API
      response = await _dio.post(forgotPasswordPath, data: FormData.fromMap(identifier));

      /// Success (Successful Request)
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      /// Failed (API Crashed)
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'Forgot_api_line_48',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }
}
