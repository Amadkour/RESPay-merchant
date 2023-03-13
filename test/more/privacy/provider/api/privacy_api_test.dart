import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/API/terms_privacy_about_api.dart';

import '../../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import 'privacy_values.dart';

void main() {
  late MockDio mockedDio;
  late TermsPrivacyAboutAPI privacyAPI;

  setUpAll(() {
    mockedDio = MockDio();
    privacyAPI = TermsPrivacyAboutAPI(dio: mockedDio);
  });

  group('Privacy api test', () {
    test('Privacy api test', () async {
      when(mockedDio.get(getPrivacyAboutValues.path)).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: getPrivacyAboutValues.successfulResponse,
          requestOptions: RequestOptions(
            path: getPrivacyAboutValues.path,
          ),
        ),
      );
      expect(
          await privacyAPI.getTermsPrivacyAbout(
              endPoint: getPrivacyAboutValues.path),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
