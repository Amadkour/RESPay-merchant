import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/api/customer_loyalty_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/models/customer_loyality_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/repo/customer_repo.dart';

import '../api/customer_loyalty_values.dart';
import 'customer_loyalty_repo.mocks.dart';

@GenerateMocks(<Type>[
  CustomerLoyaltyApi,
])
void main() {
  late MockCustomerLoyaltyApi mockCustomerLoyaltyApi;
  late CustomerLoyaltyRepo customerLoyaltyRepo;

  setUpAll(() {
    mockCustomerLoyaltyApi = MockCustomerLoyaltyApi();
    customerLoyaltyRepo = CustomerLoyaltyRepo(mockCustomerLoyaltyApi);
  });

  group('Customer Loyalty Repo', () {
    test('getLoyalties Loyalty Repo', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
      Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
            statusCode: 200,
            data: getLoyaltiesValues.successfulResponse,
            requestOptions: RequestOptions(
              path: getLoyaltiesValues.path,
            ),
          ));

      when(mockCustomerLoyaltyApi.getLoyalties())
          .thenAnswer((Invocation realInvocation) async => response);

      expect(await customerLoyaltyRepo.getLoyalties(),
          isA<Right<Failure, ParentModel>>());
    });



    test('show Loyalty Repo', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
      Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
            statusCode: 200,
            data: showLoyaltiesValues.successfulResponse,
            requestOptions: RequestOptions(
              path: showLoyaltiesValues.path,
            ),
          ));

      when(mockCustomerLoyaltyApi.show("uuid"))
          .thenAnswer((Invocation realInvocation) async => response);

      expect(await customerLoyaltyRepo.show("uuid"),
          isA<Right<Failure, CustomerLoyaltyModel>>());
    });

    test('fail redeem Loyalty Repo', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
      Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
            statusCode: 400,
            data: redeemLoyaltiesValues.failureResponse,
            requestOptions: RequestOptions(
              path: redeemLoyaltiesValues.path,
            ),
          ));

      when(mockCustomerLoyaltyApi.show("uuid"))
          .thenAnswer((Invocation realInvocation) async => response);

      expect(await customerLoyaltyRepo.redeem(redeemFailureBody['shop_uuid'] as  String),
          isA<Left<Failure, String>>());
    });
























  });
}
