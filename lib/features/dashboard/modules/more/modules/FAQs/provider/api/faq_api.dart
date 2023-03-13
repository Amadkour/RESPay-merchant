import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';

import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/provider/api/end_point.dart';

class FAQApi {
  late Dio _dio;

  FAQApi({Dio? dio}) {
    _dio = dio ?? APIConnection.instance.dio;
  }

  FAQApi._singleTone() {
    _dio = APIConnection.instance.dio;
  }

  static final FAQApi _instance = FAQApi._singleTone();

  static FAQApi get instance => _instance;

  Future<Either<Failure, Response<Map<String, dynamic>>>> getFAQs() async {
    late Response<Map<String, dynamic>> response;
    try {
      response = await _dio.get(getFAQPath);
      return Right<Failure, Response<Map<String, dynamic>>>(response);
    } catch (e) {
      return Left<Failure, Response<Map<String, dynamic>>>(ApiFailure(
          code: response.statusCode,
          resourceName: 'getTermsPrivacyAbout_line_36',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }
}
