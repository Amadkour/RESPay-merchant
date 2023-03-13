import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/Api/forget_password_api.dart';

import '../../../../core/utilis.dart';
import '../../../registration/provider/api/regestration_api_test.mocks.dart';
import '../forget_password_values.dart';

void main() {
  late ForgotPasswordAPI forgotPasswordAPI;
  late MockDio mockDio;

  setUpAll(() {
    mockDio = MockDio();
    forgotPasswordAPI = ForgotPasswordAPI(dio: mockDio);
  });

  group('Forget Password API test', () {
    test('test on success', () async {
      when(mockDio.post(
        forgetPasswordValues.path,
        data: compare(forgetPasswordValues.successfulBody!),
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: forgetPasswordValues.successfulResponse,
          requestOptions: RequestOptions(
            path: forgetPasswordValues.path,
          ),
        ),
      );
      expect(await forgotPasswordAPI.forgotPassword(identifier: <String, String>{'identity_id': '20232023'}),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('test on failure', () async {
      when(mockDio.post(
        forgetPasswordValues.path,
        data: anything,
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 422,
          data: forgetPasswordValues.failureResponse,
          requestOptions: RequestOptions(
            path: forgetPasswordValues.path,
          ),
        ),
      );

      expect(
          await forgotPasswordAPI.forgotPassword(
            identifier: <String, String>{'identity_id': '20232021'},
          ),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
