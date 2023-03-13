import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/API/login_api.dart';

import '../../../../core/utilis.dart';
import '../../../registration/provider/api/regestration_api_test.mocks.dart';
import '../login_values.dart';

void main() {
  late LoginApi loginApi;

  late MockDio mockDio;

  setUpAll(() {
    mockDio = MockDio();
    loginApi = LoginApi(dio: mockDio);
  });

  ///------------------------------------ Login --------------------------------///
  group('Login API test', () {
    test('test on success', () async {
      when(mockDio.post(
        loginValues.path,
        data: compare(loginValues.successfulBody!),
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: loginValues.successfulResponse,
          requestOptions: RequestOptions(
            path: loginValues.path,
          ),
        ),
      );
      expect(await loginApi.loginAPI(loginInput), isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('test on failure', () async {
      when(
        mockDio.post(loginValues.path, data: compare(loginValues.failureBody!)),
      ).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 400,
          data: loginValues.failureResponse,
          requestOptions: RequestOptions(
            path: loginValues.path,
          ),
        ),
      );

      final Either<Failure, Response<Map<String, dynamic>>> result = await loginApi.loginAPI(loginInput);

      final dynamic object = result.fold((Failure l) => l, (Response<Map<String, dynamic>> r) => r);
      expect(object, isA<ApiFailure>());
    });
  });
}
