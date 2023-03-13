import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/provider/api/promotions_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/provider/repo/promotions_repo.dart';

import '../../promotions_values.dart';
import 'promotions_repo_test.mocks.dart';

@GenerateMocks(<Type>[PromotionsApi])
void main() {
  late MockPromotionsApi mockPromotionsApi;

  late PromotionsRepo promotionsRepo;

  setUpAll(() {
    mockPromotionsApi = MockPromotionsApi();
    promotionsRepo = PromotionsRepo(mockPromotionsApi);
  });

  group('get Promotions test', () {
    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: getPromotionsValues.successfulResponse,
              statusCode: 201,
              requestOptions: RequestOptions(path: getPromotionsValues.path)));

      when(mockPromotionsApi.getPromotions())
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await promotionsRepo.getPromotions(),
          isA<Right<Failure, ParentModel>>());
    });

    test('get Promotions test fail', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: getPromotionsValues.failureResponse,
              statusCode: 404,
              requestOptions: RequestOptions(path: getPromotionsValues.path)));

      when(mockPromotionsApi.getPromotions())
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await promotionsRepo.getPromotions(),
          isA<Left<Failure, ParentModel>>());
    });
  });
}
