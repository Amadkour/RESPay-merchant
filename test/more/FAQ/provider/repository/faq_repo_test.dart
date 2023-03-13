import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/provider/api/faq_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/provider/repository/faq_repo.dart';

import '../API/faq_values.dart';
import 'faq_repo_test.mocks.dart';

@GenerateMocks(<Type>[
  FAQApi,
])
void main() {
  late FAQsRepo faQsRepo;
  late MockFAQApi mockFAQApi;

  setUpAll(() {
    mockFAQApi = MockFAQApi();
    faQsRepo = FAQsRepo(faqApi: mockFAQApi);
  });

  group("FAQ repo test", () {
    test('getFAQs test', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
        statusCode: 200,
        data: faqValues.successfulResponse,
        requestOptions: RequestOptions(
          path: faqValues.path,
        ),
      ));

      when(mockFAQApi.getFAQs())
          .thenAnswer((Invocation realInvocation) async => response);

      expect(await faQsRepo.getFAQs(), isA<Right<Failure, ParentModel>>());
    });
  });
}
