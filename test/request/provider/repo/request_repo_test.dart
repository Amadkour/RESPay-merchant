import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/api/request_remote_api.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/repos/request_repo.dart';
import '../../request_values.dart';
import '../../send_money_request_values.dart';
import 'request_repo_test.mocks.dart';

@GenerateMocks(<Type>[RequestRemoteApi])
void main() {
  late MockRequestRemoteApi mockRequestRemoteApi;

  late RequestRemoteRepo requestRemoteRepo;

  setUpAll(() {
    mockRequestRemoteApi = MockRequestRemoteApi();
    requestRemoteRepo = RequestRemoteRepo(mockRequestRemoteApi);
  });

  group('Add New Request Beneficiary test', () {
    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: addNewRequestBeneficiaryValues.successfulResponse,
              statusCode: 201,
              requestOptions: RequestOptions(path: addNewRequestBeneficiaryValues.path)));

      when(mockRequestRemoteApi.addNewRequestBeneficiary(input: addNewRequestBeneficiarySuccessInput))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await requestRemoteRepo.addNewRequestBeneficiary(input: addNewRequestBeneficiarySuccessInput),
          isA<Right<Failure, ParentModel>>());
    });

    test('Add New Request Beneficiary using user not found in server', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: addNewRequestBeneficiaryValues.failureResponse,
              statusCode: 404,
              requestOptions: RequestOptions(path: addNewRequestBeneficiaryValues.path)));

      when(mockRequestRemoteApi.addNewRequestBeneficiary(input: addNewRequestBeneficiaryFailureInput))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await requestRemoteRepo.addNewRequestBeneficiary(input: addNewRequestBeneficiaryFailureInput),
          isA<Left<Failure, ParentModel>>());
    });
  });

  group('test send money', () {
    test('test success send money', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: sendMoneyValues.successfulResponse,
              statusCode: 200,
              requestOptions: RequestOptions(path: sendMoneyValues.path)));

      when(mockRequestRemoteApi.sendMoney(input: sendMoneySuccessInput))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await requestRemoteRepo.requestMoney(input: sendMoneySuccessInput), isA<Right<Failure, ParentModel>>());
    });

    test('test Failed Send Money', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: sendMoneyValues.failureResponse,
              statusCode: 404,
              requestOptions: RequestOptions(path: sendMoneyValues.path)));

      when(mockRequestRemoteApi.sendMoney(input: sendMoneyFailureInput))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await requestRemoteRepo.requestMoney(input: sendMoneyFailureInput), isA<Left<Failure, ParentModel>>());
    });
  });
}
