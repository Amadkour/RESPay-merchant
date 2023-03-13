import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/api/customer_loyalty_api.dart';

import '../../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../../../core/utilis.dart';
import 'customer_loyalty_values.dart';

void main() {
  late MockDio mockDio;
  late CustomerLoyaltyApi customerLoyaltyApi;
  setUpAll(() {
    mockDio = MockDio();
    customerLoyaltyApi = CustomerLoyaltyApi(mockDio);
  });
  group('Customer loyalty test', () {
    test('getLoyalties api test', () async {
      when(mockDio.get(getLoyaltiesValues.path)).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: getLoyaltiesValues.successfulResponse,
          requestOptions: RequestOptions(
            path: getLoyaltiesValues.path,
          ),
        ),
      );
      expect(await customerLoyaltyApi.getLoyalties(),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });


    test('show api test', () async {
      when(mockDio
          .get(showLoyaltiesValues.path, queryParameters: <String, dynamic>{
        "shop_uuid": "uuid",
      })).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: showLoyaltiesValues.successfulResponse,
          requestOptions: RequestOptions(
            path: showLoyaltiesValues.path,
          ),
        ),
      );
      expect(await customerLoyaltyApi.show("uuid"),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('redeem failure api test', () async {
      when(mockDio
          .post(redeemLoyaltiesValues.path,data: compare(redeemLoyaltiesValues.failureBody!))).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 400,
          data: redeemLoyaltiesValues.failureResponse,
          requestOptions: RequestOptions(
            path: redeemLoyaltiesValues.path,
          ),
        ),
      );
      expect(await customerLoyaltyApi.redeem(redeemFailureBody['shop_uuid'] as String),
          isA<Left<Failure, Response<Map<String, dynamic>>>>());
    });



  });
}
