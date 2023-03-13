import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/provider/api/faq_api.dart';

import '../../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import 'faq_values.dart';

void main() {
  late MockDio mockDio;
  late FAQApi faqApi;

  setUpAll(() {
    mockDio = MockDio();
    faqApi = FAQApi(dio: mockDio);
  });

  group('FAQ API test', () {
    test('getFAQs api test', () async {
      when(mockDio.get(faqValues.path)).thenAnswer(
          (Invocation realInvocation) async => Response<Map<String, dynamic>>(
              requestOptions: RequestOptions(path: faqValues.path),
              data: faqValues.successfulResponse,
              statusCode: 200));

      expect(await faqApi.getFAQs(),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
