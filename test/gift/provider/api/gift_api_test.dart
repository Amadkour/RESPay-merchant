import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/provider/api/gift_remote_api.dart';

import '../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../gift_values.dart';

void main() {
  late MockDio mockedDio;
  late GiftRemoteApi api;

  setUpAll(() {
    mockedDio = MockDio();
    api = GiftRemoteApi.withDio(dio: mockedDio);
  });
  group("Send Gift Api", () {
    test('Send Gift Api Success Test', () async {
      when(mockedDio.post(sendGiftValue.path, data: anything)).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 201,
          data: sendGiftValue.successfulResponse,
          requestOptions: RequestOptions(
            path: sendGiftValue.path,
          ),
        ),
      );
      expect(await api.sendGift(input: sendGiftSuccessInput), isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('Send Gift Api Failed Test', () async {
      when(mockedDio.post(sendGiftValue.path, data: sendGiftValue.failureBody))
          .thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: sendGiftValue.failureResponse,
          requestOptions: RequestOptions(
            path: sendGiftValue.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.sendGift(input: sendGiftFailureInput);
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  group("New Gift Beneficiary Api", () {
    test('New Gift Beneficiary Api Success Test', () async {
      when(mockedDio.post(addNewGiftBeneficiaryValues.path, data: anything)).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 201,
          data: addNewGiftBeneficiaryValues.successfulResponse,
          requestOptions: RequestOptions(
            path: addNewGiftBeneficiaryValues.path,
          ),
        ),
      );
      expect(await api.addNewGiftBeneficiary(input: giftSuccessInput),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('New Gift Beneficiary Api Failed Test', () async {
      when(mockedDio.post(sendGiftValue.path, data: addNewGiftBeneficiaryValues.failureBody))
          .thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: addNewGiftBeneficiaryValues.failureResponse,
          requestOptions: RequestOptions(
            path: addNewGiftBeneficiaryValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result =
          await api.addNewGiftBeneficiary(input: giftFailureInput);
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
