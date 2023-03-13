import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/provider/api/end_point.dart';

class PinCodeAPI {
  late Dio _dio;

  PinCodeAPI({Dio? dio}) {
    _dio = dio ?? APIConnection.instance.dio;
  }

  PinCodeAPI._singleTone(){
    _dio = APIConnection.instance.dio;
  }

  static final PinCodeAPI _instance = PinCodeAPI._singleTone();

  static PinCodeAPI get instance => _instance;

  Future<Either<Failure, Response<Map<String, dynamic>>>> setUpPinCode(
      String code, int enableFaceId, int enableFingerprint) async {

    try {
      final Response<Map<String, dynamic>> response = await _dio.post(
        pinPath,
        data: <String, dynamic>{
          'pin_code': code,
          'is_touch_active': enableFingerprint,
          'is_face_active': enableFaceId,
        },
      );

      if (response.statusCode == 200 && response.data?['success'] == true) {
        return right(response);
      } else {
        return left(
          ApiFailure(
              code: response.statusCode,
              resourceName: 'pin_code_line_18',
              errors: (response.data!['errors'] ?? <dynamic>{}) as Map<String, dynamic>),
        );
      }
    } on DioError catch (e) {
      return left(
        ApiFailure(
          code: e.response?.statusCode,
          resourceName: 'Registration_api_line_54',
          errors: (e.response as Response<Map<String, dynamic>>?)?.data?['errors'] as Map<String, dynamic>?,
        ),
      );
    }
  }
}
