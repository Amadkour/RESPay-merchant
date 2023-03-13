import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/api_connection.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/notification_service.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/API/end_point.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/login_input.dart';

class LoginApi {
  late Dio _dio;

  LoginApi({Dio? dio}) {
    _dio = dio ?? APIConnection.instance.dio;
  }

  LoginApi._singleTone() {
    _dio = APIConnection.instance.dio;
  }

  static final LoginApi _instance = LoginApi._singleTone();

  static LoginApi get instance => _instance;

  Future<Either<Failure, Response<Map<String, dynamic>>>> loginAPI(LoginInput input) async {
    late Response<Map<String, dynamic>> response;
    log(await sl<NotificationService>().getDeviceToken());
    try {
      final Map<String, dynamic> loginMap = <String, dynamic>{
        'password': input.password,
        "fcm_token": input.deviceToken,
        "os_type": input.osType,
      };

      /// Login with Identity ID
      if (input.phoneNumber == null && input.email == null) {
        loginMap['identity_id'] = input.identityId;
      }

      /// Login with Phone Number
      else if (input.identityId == null && input.email == null) {
        loginMap['phone_number'] = input.phoneNumber;

        /// Login with email
      } else if (input.identityId == null && input.phoneNumber == null) {
        loginMap['email'] = input.email;
      }
      response = await _dio.post(
        loginPath,
        data: loginMap,
      );
      final Map<String, dynamic>? body = response.data;
      if (body!['success'] == true) {
        return right(response);
      } else {
        return left(ApiFailure(
          errors: Map<String, dynamic>.from(body['errors'] as Map<dynamic, dynamic>),
        ));
      }
    } catch (e) {
      return left(ApiFailure(
          code: response.statusCode,
          resourceName: 'login_api_line_59',
          errors: response.data!['errors'] as Map<String, dynamic>));
    }
  }

  Future<Map<String, dynamic>> loginWitRes({String? identityId, required String password, String? phoneNumber}) async {
    try {
      late final FormData formData;

      /// Login with Identity ID
      if (phoneNumber == null) {
        formData = FormData.fromMap(<String, dynamic>{'identity_id': identityId, 'password': password});
      }

      /// Login with Phone Number
      else if (identityId == null) {
        formData = FormData.fromMap(<String, dynamic>{'phone_number': phoneNumber, 'password': password});
      }
      final Response<Map<String, dynamic>> response = await _dio.post(loginWithResPath,
          data: formData, options: Options(headers: <String, String>{'Accept-Language': 'en'}));
      return response.data!;
    } catch (e) {
      return <String, dynamic>{};
    }
  }
}
