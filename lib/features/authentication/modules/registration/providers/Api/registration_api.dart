import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/authentication/modules/registration/providers/Api/end_point.dart';
import 'package:res_pay_merchant/features/authentication/modules/registration/providers/models/register_inputs.dart';
class RegistrationAPI {
  late Dio _dio;

  RegistrationAPI({Dio? d}) {
    _dio = d ?? APIConnection.instance.dio;
  }

  RegistrationAPI._singleTone(){
    _dio = APIConnection.instance.dio;
  }

  static final RegistrationAPI _instance = RegistrationAPI._singleTone();

  static RegistrationAPI get instance => _instance;

  /// Function should't take more than two parameters
  Future<Either<Failure, Response<Map<String, dynamic>>>> registration(
      RegisterInputs inputs) async {
    try {
      final Response<Map<String, dynamic>> response =
          await _dio.post(registrationPath, data: FormData.fromMap(inputs.toMap()));

      final Map<String, dynamic>? body = response.data;
      if (body!['success'] == true) {
        return right(response);
      } else {
        return left(ApiFailure(
          errors: Map<String, dynamic>.from(body['errors'] as Map<dynamic, dynamic>),
        ));
      }
    } on DioError catch (e) {
      return left(ApiFailure(
          code: e.response?.statusCode,
          resourceName: 'Registration_api_line_54',
          errors: (e.response?.data as Map<String, dynamic>?)?['errors'] as Map<String, dynamic>?));
    }
  }
}
