import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/API/profile_api.dart';

import '../../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../profile_values.dart';

void main() {
  late MockDio mockedDio;
  late ProfileAPI api;

  setUpAll(() {
    mockedDio = MockDio();
    api = ProfileAPI.withDio(dio: mockedDio);
  });
  group("show profile Api", () {
    test('show profile Api Success Test', () async {
      when(mockedDio.get(showProfileValues.path)).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: showProfileValues.successfulResponse,
          requestOptions: RequestOptions(
            path: showProfileValues.path,
          ),
        ),
      );
      expect(await api.showProfile(), isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('show profile Api Failed Test', () async {
      when(mockedDio.get(showProfileValues.path)).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: showProfileValues.failureResponse,
          requestOptions: RequestOptions(
            path: showProfileValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.showProfile();
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  group("update profile Api", () {
    test('update profile Api Success Test', () async {
      when(mockedDio.post(updateProfileValues.path, data: anything)).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: updateProfileValues.successfulResponse,
          requestOptions: RequestOptions(
            path: updateProfileValues.path,
          ),
        ),
      );
      expect(await api.updateProfile(inputs: updateProfileSuccessInput),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('update profile Api Failed Test', () async {
      when(mockedDio.post(updateProfileValues.path, data: updateProfileValues.failureBody))
          .thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: updateProfileValues.failureResponse,
          requestOptions: RequestOptions(
            path: updateProfileValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result =
          await api.updateProfile(inputs: updateProfileFailureInput);
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
