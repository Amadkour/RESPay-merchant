import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/provider/API/language_api.dart';

import '../../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../../../core/utilis.dart';
import 'change_language_values.dart';

void main() {
  late MockDio mockedDio;
  late LanguageAPI languageAPI;

  setUpAll(() {
    mockedDio = MockDio();
    languageAPI = LanguageAPI(dio: mockedDio);
  });

  group('Change language api test', () {
    test('getLanguages api test', () async {
      when(mockedDio.get(getLanguageValues.path)).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: getLanguageValues.successfulResponse,
          requestOptions: RequestOptions(
            path: getLanguageValues.path,
          ),
        ),
      );
      expect(await languageAPI.getLanguages(),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('getLanguages api test', () async {
      when(mockedDio.get(getLanguageValues.path)).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: getLanguageValues.successfulResponse,
          requestOptions: RequestOptions(
            path: getLanguageValues.path,
          ),
        ),
      );
      expect(await languageAPI.getLanguages(),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('setLanguage api test', () async {
      when(mockedDio.post(setLanguageValues.path,
              data: compare(setLanguageValues.successfulBody!)))
          .thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: setLanguageValues.successfulResponse,
          requestOptions: RequestOptions(
            path: setLanguageValues.path,
          ),
        ),
      );
      expect(
          await languageAPI.setLanguage(
              locale: setLanguageSuccessBody['locale'] as String),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
