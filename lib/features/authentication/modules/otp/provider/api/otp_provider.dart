import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/authentication/modules/otp/provider/api/end_point.dart';

class OtpApi {
  late Dio _dio;

  OtpApi({Dio? d}) {
    _dio = d ?? APIConnection.instance.dio;
  }

  OtpApi._singleTone(){
    _dio = APIConnection.instance.dio;
  }

  static final OtpApi _instance = OtpApi._singleTone();

  static OtpApi get instance => _instance;

  Future<Either<Failure, Response<Map<String, dynamic>>>> sendOTP(
      Map<String, dynamic> verificationType) async {
    late Response<Map<String, dynamic>> response;

    final FormData form = FormData.fromMap(verificationType);
    try {
      response = await _dio.post(
        otpPath,
        data: form,
      );

      if (response.statusCode != 200 || (response.data!['success'] == false)) {
        return left(
          ApiFailure(
              code: response.statusCode,
              errors: (response.data!['errors'] ?? <String, dynamic>{}) as Map<String, dynamic>),
        );
      } else {
        return Right<Failure, Response<Map<String, dynamic>>>(response);
      }
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'Registration_api_line_54',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }
}
