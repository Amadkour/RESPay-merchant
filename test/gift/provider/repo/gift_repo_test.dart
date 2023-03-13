import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/provider/api/gift_remote_api.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/provider/repos/gift_repo/gift_repo.dart';

import '../../gift_values.dart';
import 'gift_repo_test.mocks.dart';


@GenerateMocks(<Type>[
  GiftRemoteApi
])

void main() {
  late MockGiftRemoteApi mockGiftRemoteApi;

  late GiftRepository giftRepository;

  setUpAll(() {
    mockGiftRemoteApi = MockGiftRemoteApi();
    giftRepository = GiftRepository(mockGiftRemoteApi);
  });

  group('Add New Gift Beneficiary test', () {

    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
      Right<Failure, Response<Map<String, dynamic>>>(Response<Map<String,dynamic>>(
        data: addNewGiftBeneficiaryValues.successfulResponse,
        statusCode: 201,
          requestOptions: RequestOptions(path: addNewGiftBeneficiaryValues.path)
      ));

      when(mockGiftRemoteApi.addNewGiftBeneficiary(input: giftSuccessInput))
          .thenAnswer((Invocation realInvocation) async => response
      );
      expect(
          await giftRepository.addNewGiftBeneficiary(input: giftSuccessInput),
          isA<Right<Failure,ParentModel>>());
    });

    test('Add New Gift Beneficiary using user not found in server', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
      Right<Failure, Response<Map<String, dynamic>>>(Response<Map<String,dynamic>>(
          data: addNewGiftBeneficiaryValues.failureResponse,
          statusCode: 404,
          requestOptions: RequestOptions(path: addNewGiftBeneficiaryValues.path)
      ));

      when(mockGiftRemoteApi.addNewGiftBeneficiary(input:giftFailureInput))
          .thenAnswer((Invocation realInvocation) async => response
      );
      expect(
          await giftRepository.addNewGiftBeneficiary(input: giftFailureInput),
          isA<Left<Failure, ParentModel>>());
    });
  });

  group('send gift test', () {

    test('send gift test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
      Right<Failure, Response<Map<String, dynamic>>>(Response<Map<String,dynamic>>(
          data: sendGiftValue.successfulResponse,
          statusCode: 201,
          requestOptions: RequestOptions(path: sendGiftValue.path)
      ));
      when(mockGiftRemoteApi.sendGift(input:sendGiftSuccessInput))
          .thenAnswer((Invocation realInvocation) async => response
      );
      expect(
          await giftRepository.sendGift(input: sendGiftSuccessInput),
          isA<Right<Failure, ParentModel>>());
    });

    test('send gift test on failed', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
      Right<Failure, Response<Map<String, dynamic>>>(Response<Map<String,dynamic>>(
          data: sendGiftValue.failureResponse,
          statusCode: 404,
          requestOptions: RequestOptions(path: sendGiftValue.path)
      ));

      when(mockGiftRemoteApi.sendGift(input:sendGiftFailureInput))
          .thenAnswer((Invocation realInvocation) async => response
      );
      expect(
          await giftRepository.sendGift(input: sendGiftFailureInput),
          isA<Left<Failure, ParentModel>>());
    });
  });
}
