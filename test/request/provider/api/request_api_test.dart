import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/api/request_remote_api.dart';

import '../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../request_values.dart';
import '../../send_money_request_values.dart';

void main() {
  late MockDio mockedDio;
  late RequestRemoteApi api;

  setUpAll(() {
    mockedDio = MockDio();
    api = RequestRemoteApi.withDio(dio: mockedDio);
  });
  group("New Request Beneficiary", () {
    test('New Request Beneficiary Test', () async {
      when(mockedDio.post(addNewRequestBeneficiaryValues.path, data: addNewRequestBeneficiarySuccessInput))
          .thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: addNewRequestBeneficiaryValues.successfulResponse,
          requestOptions: RequestOptions(
            path: addNewRequestBeneficiaryValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result =
          await api.addNewRequestBeneficiary(input: addNewRequestBeneficiarySuccessInput);
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('New Request Beneficiary Failed Test', () async {
      when(mockedDio.post(addNewRequestBeneficiaryValues.path, data: addNewRequestBeneficiaryFailureInput))
          .thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: addNewRequestBeneficiaryValues.failureResponse,
          requestOptions: RequestOptions(
            path: addNewRequestBeneficiaryValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result =
          await api.addNewRequestBeneficiary(input: addNewRequestBeneficiaryFailureInput);
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  ////////////////////////////////////////////////////////

  group("send money request ", () {
    test('send money request Test', () async {
      when(mockedDio.post(sendMoneyValues.path, data: sendMoneySuccessInput))
          .thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 201,
          data: sendMoneyValues.successfulResponse,
          requestOptions: RequestOptions(
            path: sendMoneyValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.sendMoney(input: sendMoneySuccessInput);
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('send money request Failed Test', () async {
      when(mockedDio.post(sendMoneyValues.path, data: sendMoneyFailureInput))
          .thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: sendMoneyValues.failureResponse,
          requestOptions: RequestOptions(
            path: sendMoneyValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.sendMoney(input: sendMoneyFailureInput);
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
