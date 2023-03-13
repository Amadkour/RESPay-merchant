import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/API/terms_privacy_about_api.dart';

import '../../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import 'about_values.dart';

void main() {
  late MockDio mockedDio;
  late TermsPrivacyAboutAPI termsAPI;

  setUpAll(() {
    mockedDio = MockDio();
    termsAPI = TermsPrivacyAboutAPI(dio: mockedDio);
  });


  group('About api test', () {
    test('About api test', () async {
      when(mockedDio.get(getAboutValues.path)).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: getAboutValues.successfulResponse,
          requestOptions: RequestOptions(
            path: getAboutValues.path,
          ),
        ),
      );
      expect(
          await termsAPI.getTermsPrivacyAbout(
              endPoint: getAboutValues.path),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
