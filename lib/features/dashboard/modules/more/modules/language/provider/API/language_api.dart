import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/provider/API/end_point.dart';

class LanguageAPI {
  late Dio _dio;

  LanguageAPI({Dio? dio}) {
    _dio = dio ?? APIConnection.instance.dio;
  }

  LanguageAPI._singleTone() {
    _dio = APIConnection.instance.dio;
  }

  static final LanguageAPI _instance = LanguageAPI._singleTone();

  static LanguageAPI get instance => _instance;

  Future<Either<Failure, Response<Map<String, dynamic>>>> getLanguages() async {
    late Response<Map<String, dynamic>> response;
    try {
      response = await _dio.get(getLanguagePath);
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'get_languages_list_line_32',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }

  Future<Either<Failure, Response<Map<String, dynamic>>>> setLanguage(
      {required String locale}) async {
    late Response<Map<String, dynamic>> response;
    try {
      final FormData formData =
          FormData.fromMap(<String, String>{'locale': locale});
      response = await _dio.post(setLanguagePath, data: formData);
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'set_language_line_49',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }
}
