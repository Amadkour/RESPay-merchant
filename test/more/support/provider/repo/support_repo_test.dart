import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/provider/api/support_remote_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/provider/repo/support_repo.dart';

import '../../support_values.dart';
import 'support_repo_test.mocks.dart';



@GenerateMocks(<Type>[
  SupportRemoteApi
])

void main() {
  late MockSupportRemoteApi mockSupportRemoteApi;

  late SupportRepository supportRepository;

  setUpAll(() {
    mockSupportRemoteApi = MockSupportRemoteApi();
    supportRepository = SupportRepository(mockSupportRemoteApi);
  });

  group('Add New Issue test', () {

    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
      Right<Failure, Response<Map<String, dynamic>>>(Response<Map<String,dynamic>>(
          data: sendSupportValue.successfulResponse,
          statusCode: 201,
          requestOptions: RequestOptions(path: sendSupportValue.path)
      ));

      when(mockSupportRemoteApi.sendSupportRequest(input: <String,dynamic>{
        "full_name": "hussein hamed",
        "email": "hussein@gmail.com",
        "message": "test issue",
      }))
          .thenAnswer((Invocation realInvocation) async => response
      );
      expect(
          await supportRepository.sendSupportRequest(input: <String,dynamic>{
            "full_name": "hussein hamed",
            "email": "hussein@gmail.com",
            "message": "test issue",
          }),
          isA<Right<Failure, ParentModel>>());
    });

    test('Add New Issue Failed', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
      Right<Failure, Response<Map<String, dynamic>>>(Response<Map<String,dynamic>>(
          data: sendSupportValue.failureResponse,
          statusCode: 404,
          requestOptions: RequestOptions(path: sendSupportValue.path)
      ));

      when(mockSupportRemoteApi.sendSupportRequest(input: <String, dynamic>{
        "email": "hussein@gmail.com",
        "message": "test issue",
      }))
          .thenAnswer((Invocation realInvocation) async => response
      );
      expect(
          await supportRepository.sendSupportRequest(input: <String, dynamic>{
            "email": "hussein@gmail.com",
            "message": "test issue",
          }),
          isA<Left<Failure, ParentModel>>());
    });
  });
}
