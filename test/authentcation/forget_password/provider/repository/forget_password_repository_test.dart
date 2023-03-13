import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/Api/forget_password_api.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/repository/forget_passwod_repository.dart';

import '../forget_password_values.dart';
import 'forget_password_repository_test.mocks.dart';

@GenerateMocks(<Type>[
  ForgotPasswordAPI,
])
void main() {
  late ForgetPasswordRepository forgetPasswordRepository;
  late MockForgotPasswordAPI mockForgotPasswordAPI;

  setUpAll(() {
    mockForgotPasswordAPI = MockForgotPasswordAPI();
    forgetPasswordRepository =
        ForgetPasswordRepository(forgotPasswordAPI: mockForgotPasswordAPI);
  });
  group('Forget Password Repository test', () {
    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
        statusCode: 200,
        data: forgetPasswordValues.successfulResponse,
        requestOptions: RequestOptions(
          path: forgetPasswordValues.path,
        ),
      ));

      when(mockForgotPasswordAPI.forgotPassword(
              identifier: <String, String>{"identity_id": '20232023'}))
          .thenAnswer((Invocation realInvocation) async => response);

      expect(
          await forgetPasswordRepository.forgotPasswordRepository(
              identifier: <String, String>{"identity_id": '20232023'}),
          isA<Right<Failure, String>>());
    });

    test('test on failure', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
        statusCode: 422,
        data: forgetPasswordValues.failureResponse,
        requestOptions: RequestOptions(
          path: forgetPasswordValues.path,
        ),
      ));

      when(mockForgotPasswordAPI.forgotPassword(
              identifier: <String, String>{"identity_id": '20232023'}))
          .thenAnswer((Invocation realInvocation) async => response);

      expect(
          await forgetPasswordRepository.forgotPasswordRepository(
              identifier: <String, String>{"identity_id": '20232023'}),
          isA<Left<Failure, String>>());
    });
  });
}
