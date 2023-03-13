import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/provider/api/support_remote_api.dart';

import '../../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../support_values.dart';

void main() {
  late MockDio mockedDio;
  late SupportRemoteApi api;

  setUpAll(() {
    mockedDio = MockDio();
    api = SupportRemoteApi.withDio(dio: mockedDio);
  });
  group("New Issue Api", () {
    test('New Issue Api Success Test', () async {
      when(mockedDio.post(sendSupportValue.path, data: anything)).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: sendSupportValue.successfulResponse,
          requestOptions: RequestOptions(
            path: sendSupportValue.path,
          ),
        ),
      );
      expect(
          await api.sendSupportRequest(input: <String, dynamic>{
            "full_name": "hussein hamed",
            "email": "hussein@gmail.com",
            "message": "test issue",
          }),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('New Issue Api Failed Test', () async {
      when(mockedDio.post(sendSupportValue.path, data: sendSupportValue.failureBody))
          .thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: sendSupportValue.failureResponse,
          requestOptions: RequestOptions(
            path: sendSupportValue.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result =
          await api.sendSupportRequest(input: <String, dynamic>{
        "email": "hussein@gmail.com",
        "message": "test issue",
      });
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
