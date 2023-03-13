import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/API/terms_privacy_about_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/repository/terms_privacy_about_repository.dart';

import '../../../terms/provider/repo/terms_repo_test.mocks.dart';
import '../api/about_values.dart';

@GenerateMocks(<Type>[
  TermsPrivacyAboutAPI,
])
void main() {
  late TermPrivacyAboutRepository termPrivacyAboutRepository;
  late MockTermsPrivacyAboutAPI mockTermsPrivacyAboutAPI;


  setUpAll(() {
    mockTermsPrivacyAboutAPI = MockTermsPrivacyAboutAPI();
    termPrivacyAboutRepository =
        TermPrivacyAboutRepository(
            termsPrivacyAboutAPI: mockTermsPrivacyAboutAPI);
  });

  group("About repo test", () {
    test('getTermsPrivacyAboutRepository test', () async{
      final Either<Failure, Response<Map<String, dynamic>>> response =
      Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
            statusCode: 200,
            data: getAboutValues.successfulResponse,
            requestOptions: RequestOptions(
              path: getAboutValues.path,
            ),
          ));

      when(
          mockTermsPrivacyAboutAPI.getTermsPrivacyAbout(endPoint: getAboutValues.path))
          .thenAnswer((Invocation realInvocation) async => response);

      expect(await termPrivacyAboutRepository.getTermsPrivacyAboutRepository(
          endPoint:getAboutValues.path), isA<Right<Failure,ParentModel>>()
      );
    });
  });
}
