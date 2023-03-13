import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/Api/create_new_password_api.dart';

import '../../../registration/provider/api/regestration_api_test.mocks.dart';
import '../create_new_password_values.dart';

void main() {
  late CreateNewPasswordAPI createNewPasswordAPI;
  late MockDio mockDio;

  setUpAll(() {
    mockDio = MockDio();
    createNewPasswordAPI = CreateNewPasswordAPI(dio: mockDio);
  });

  group('Forget Password API test', () {
    test('test on success', () async {
      when(mockDio.post(
        createNewPasswordValues.path,
        data: anything,
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: createNewPasswordValues.successfulResponse,
          requestOptions: RequestOptions(
            path: createNewPasswordValues.path,
          ),
        ),
      );
      expect(
          await createNewPasswordAPI.resetPassword(
            map: <String, String>{'identity_id': '20232023', 'password': 'Mobile@2022'},
          ),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('test on failure', () async {
      when(mockDio.post(
        createNewPasswordValues.path,
        data: anything,
      )).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 422,
          data: createNewPasswordValues.failureResponse,
          requestOptions: RequestOptions(
            path: createNewPasswordValues.path,
          ),
        ),
      );

      expect(
          await createNewPasswordAPI.resetPassword(
            map: <String, String>{'identity_id': '20232022', 'password': 'Mobile@2022'},
          ),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
