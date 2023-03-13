import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/settings/modules/change_password/provider/API/end_point.dart';

class ChangePasswordAPI {
  late Dio _dio;

  ChangePasswordAPI({Dio? dio}) {
    _dio = dio ?? APIConnection.instance.dio;
  }

  ChangePasswordAPI._singleTone() {
    _dio = APIConnection.instance.dio;
  }

  static final ChangePasswordAPI _instance = ChangePasswordAPI._singleTone();

  static ChangePasswordAPI get instance => _instance;

  /// Change password API
  Future<Either<Failure, Response<Map<String, dynamic>>>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    late Response<Map<String, dynamic>> response;

    try {
      final FormData formData = FormData.fromMap(<String, dynamic>{
        'old_password': oldPassword,
        'new_password': newPassword,
        'new_password_confirmation': newPasswordConfirmation,
      });
      response = await _dio.post(changePasswordPath, data: formData);
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'change_password_api_line_45',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }
}
