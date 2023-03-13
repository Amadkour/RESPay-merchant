import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/Api/create_new_password_api.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/repository/create_new_password_repository.dart';

import '../create_new_password_values.dart';
import 'create_password_repository_test.mocks.dart';


@GenerateMocks(<Type>[
  CreateNewPasswordAPI,
])
void main() {
  late CreateNewPasswordRepository createNewPasswordRepository;
  late MockCreateNewPasswordAPI mockCreateNewPasswordAPI;

  setUpAll(() {
    mockCreateNewPasswordAPI = MockCreateNewPasswordAPI();
    createNewPasswordRepository = CreateNewPasswordRepository(
        createNewPasswordAPI: mockCreateNewPasswordAPI);
  });
  group('Create new Password Repository test', () {
    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
        statusCode: 200,
        data: createNewPasswordValues.successfulResponse,
        requestOptions: RequestOptions(
          path: createNewPasswordValues.path,
        ),
      ));

      when(mockCreateNewPasswordAPI.resetPassword(map: <String, String>{
        'identity_id': '20232023',
        'password': 'Mobile@2022'
      })).thenAnswer((Invocation realInvocation) async => response);

      expect(
          await createNewPasswordRepository.resetPasswordRepository(
              map: <String, String>{
                'identity_id': '20232023',
                'password': 'Mobile@2022'
              }),
          isA<Right<Failure, Map<String, dynamic>>>());
    });
    test('test on failure', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
        statusCode: 422,
        data: createNewPasswordValues.failureResponse,
        requestOptions: RequestOptions(
          path: createNewPasswordValues.path,
        ),
      ));

      when(mockCreateNewPasswordAPI.resetPassword(map: <String, String>{
        'identity_id': '20232022',
        'password': 'Mobile@2022'
      })).thenAnswer((Invocation realInvocation) async => response);

      expect(
          await createNewPasswordRepository.resetPasswordRepository(
              map: <String, String>{
                'identity_id': '20232022',
                'password': 'Mobile@2022'
              }),
          isA<Left<Failure, Map<String, dynamic>>>());
    });

  });
}
