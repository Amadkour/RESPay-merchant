import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/provider/api/promotions_api.dart';

import '../../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../promotions_values.dart';

void main() {
  late MockDio mockedDio;
  late PromotionsApi api;

  setUpAll(() {
    mockedDio = MockDio();
    api = PromotionsApi.withDio(dio: mockedDio);
  });
  group("getPromotions", () {
    test('getPromotions Test', () async {
      when(mockedDio.get(getPromotionsValues.path)).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: getPromotionsValues.successfulResponse,
          requestOptions: RequestOptions(
            path: getPromotionsValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getPromotions();
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('getPromotions Failed Test', () async {
      when(mockedDio.post(getPromotionsValues.path)).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: getPromotionsValues.failureResponse,
          requestOptions: RequestOptions(
            path: getPromotionsValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getPromotions();
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
