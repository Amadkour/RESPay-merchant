import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';

class TermsPrivacyAboutAPI {
  late Dio _dio;

  TermsPrivacyAboutAPI({Dio? dio}) {
    _dio = dio ?? APIConnection.instance.dio;
  }

  TermsPrivacyAboutAPI._singleTone() {
    _dio = APIConnection.instance.dio;
  }

  static final TermsPrivacyAboutAPI _instance =
      TermsPrivacyAboutAPI._singleTone();

  static TermsPrivacyAboutAPI get instance => _instance;

  Future<Either<Failure, Response<Map<String, dynamic>>>> getTermsPrivacyAbout(
      {required String endPoint}) async {
    late Response<Map<String, dynamic>> response;
    try {
      response = await _dio.get(endPoint);
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'getTermsPrivacyAbout_line_36',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }
}
