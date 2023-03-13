import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/Api/end_point.dart';

class CreateNewPasswordAPI {
  late Dio _dio;

  /// ------------------------ Pass [Dio] To use it in testing ------------------------ ///
  CreateNewPasswordAPI({Dio? dio}) {
    _dio = dio ?? APIConnection.instance.dio;
  }
  /// --------------------------- SingleTone API ------------------------ ///
  CreateNewPasswordAPI._singleTone() {
    _dio = APIConnection.instance.dio;
  }

  static final CreateNewPasswordAPI _instance =
      CreateNewPasswordAPI._singleTone();

  static CreateNewPasswordAPI get instance => _instance;

  /// Reset password API
  Future<Either<Failure, Response<Map<String, dynamic>>>> resetPassword(
      {required Map<String, dynamic> map}) async {
    late Response<Map<String, dynamic>> response;
    try {
      final FormData formData = FormData.fromMap(map);
      /// ----------------- Calling API ----------------- ///
      response = await _dio.post(resetPasswordPath, data: formData);

      /// Success (Successful Request)
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      /// Failed (API Crashed)
      return Left<Failure, Response<Map<String, dynamic>>>(
        ApiFailure(

            code: response.statusCode,
            resourceName: 'reset_password_api_line_39',
            errors: response.data!['errors'] as Map<String, dynamic>),
      );
    }
  }
}
