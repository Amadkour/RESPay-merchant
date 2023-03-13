import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/registration/providers/Api/end_point.dart';
import 'package:res_pay_merchant/features/authentication/modules/registration/providers/Api/registration_api.dart';

import '../../../../core/utilis.dart';
import '../registration_values.dart';
import 'regestration_api_test.mocks.dart';

@GenerateMocks(<Type>[Dio])
void main() {
  late RegistrationAPI registrationAPI;

  late MockDio mockDio;

  setUpAll(() {
    mockDio = MockDio();
    registrationAPI = RegistrationAPI(d: mockDio);
  });

  group('Registration API test', () {
    test('test on success', () async {
      when(
        mockDio.post(registrationPath, data: anything),
      ).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: registrationValues.successfulResponse,
          requestOptions: RequestOptions(
            path: registrationValues.path,
          ),
        ),
      );

      expect(await registrationAPI.registration(registrationInputs),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('test on failure', () async {
      when(
        mockDio.post(
          registrationValues.path,
          data: compare(FormData.fromMap(registrationInputs.toMap())),
        ),
      ).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: registrationValues.failureResponse,
          requestOptions: RequestOptions(
            path: registrationValues.path,
          ),
        ),
      );

      final Either<Failure, Response<Map<String, dynamic>>> result =
          await registrationAPI.registration(registrationInputs);
      final Object failure = result.fold(
          (Failure l) => l, (Response<Map<String, dynamic>> r) => r);
      expect(failure, isA<ApiFailure>());
    });
  });
}
