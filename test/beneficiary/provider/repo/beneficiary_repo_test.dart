import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/beneficiary/beneficiary_remote_api.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/repos/beneficiary/beneficiary_repo.dart';

import '../../beneficiary_values.dart';
import 'beneficiary_repo_test.mocks.dart';

@GenerateMocks(<Type>[BeneficiaryRemoteApi])
void main() {
  late MockBeneficiaryRemoteApi mockBeneficiaryBaseApi;

  late BeneficiaryRemoteRepo beneficiaryRemoteRepo;

  setUpAll(() {
    mockBeneficiaryBaseApi = MockBeneficiaryRemoteApi();
    beneficiaryRemoteRepo = BeneficiaryRemoteRepo(mockBeneficiaryBaseApi);
  });

  group('Add New Transfer Beneficiary test', () {
    test('Add New Transfer Beneficiary success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
                  data: addNewTransferBeneficiaryValues.successfulResponse,
                  statusCode: 201,
                  requestOptions: RequestOptions(
                      path: addNewTransferBeneficiaryValues.path)));

      when(mockBeneficiaryBaseApi.createTransferBeneficiary(
              inputs: successAddNewTransferBeneficiaryInput))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(
          await beneficiaryRemoteRepo.addNewTransferBeneficiary(
              inputs: successAddNewTransferBeneficiaryInput),
          isA<Right<Failure, ParentModel>>());
    });

    test('Add New Transfer Beneficiary failed', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
                  data: addNewTransferBeneficiaryValues.failureResponse,
                  statusCode: 404,
                  requestOptions: RequestOptions(
                      path: addNewTransferBeneficiaryValues.path)));

      when(mockBeneficiaryBaseApi.createTransferBeneficiary(
              inputs: failureAddNewTransferBeneficiaryInput))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(
          await beneficiaryRemoteRepo.addNewTransferBeneficiary(
              inputs: failureAddNewTransferBeneficiaryInput),
          isA<Left<Failure, ParentModel>>());
    });
  });

  ////////////////////////////////////////////////////////////

  group('Get All Gift Beneficiaries test', () {
    test('Get All Gift Beneficiaries success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
                  data: getAllGiftBeneficiariesValues.successfulResponse,
                  statusCode: 200,
                  requestOptions: RequestOptions(
                      path: getAllGiftBeneficiariesValues.path,
                      queryParameters: <String, dynamic>{"method": "Gift"})));

      when(mockBeneficiaryBaseApi.getBeneficiaries(method: "Gift"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await beneficiaryRemoteRepo.getBeneficiary(method: "Gift"),
          isA<Right<Failure, ParentModel>>());
    });

    test('Get All Gift Beneficiaries failed', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
                  data: getAllGiftBeneficiariesValues.failureResponse,
                  statusCode: 404,
                  requestOptions: RequestOptions(
                      path: getAllGiftBeneficiariesValues.path,
                      queryParameters: <String, dynamic>{"method": "Gift"})));

      when(mockBeneficiaryBaseApi.getBeneficiaries(method: "Gift"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await beneficiaryRemoteRepo.getBeneficiary(method: "Gift"),
          isA<Left<Failure, ParentModel>>());
    });
  });

  ////////////////////////////////////////////////////////////

  group('Get All Transfer Beneficiaries test', () {
    test('Get All Transfer Beneficiaries success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
                  data: getAllTransferBeneficiariesValues.successfulResponse,
                  statusCode: 200,
                  requestOptions: RequestOptions(
                      path: getAllTransferBeneficiariesValues.path)));

      when(mockBeneficiaryBaseApi.getBeneficiaries())
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await beneficiaryRemoteRepo.getBeneficiary(),
          isA<Right<Failure, ParentModel>>());
    });

    test('Get All Transfer Beneficiaries failed', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
                  data: getAllTransferBeneficiariesValues.failureResponse,
                  statusCode: 404,
                  requestOptions: RequestOptions(
                      path: getAllTransferBeneficiariesValues.path)));

      when(mockBeneficiaryBaseApi.getBeneficiaries())
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await beneficiaryRemoteRepo.getBeneficiary(),
          isA<Left<Failure, ParentModel>>());
    });
  });

  ////////////////////////////////////////////////////////////

  group('Get All Request Beneficiaries test', () {
    test('Get All Request Beneficiaries success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
                  data: getAllRequestBeneficiariesValues.successfulResponse,
                  statusCode: 200,
                  requestOptions: RequestOptions(
                      path: getAllRequestBeneficiariesValues.path,
                      queryParameters: <String, dynamic>{
                        "method": "Request Money"
                      })));

      when(mockBeneficiaryBaseApi.getBeneficiaries(method: "Request Money"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(
          await beneficiaryRemoteRepo.getBeneficiary(method: "Request Money"),
          isA<Right<Failure, ParentModel>>());
    });

    test('Get All Request Beneficiaries failed', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
                  data: getAllRequestBeneficiariesValues.failureResponse,
                  statusCode: 404,
                  requestOptions: RequestOptions(
                      path: getAllRequestBeneficiariesValues.path,
                      queryParameters: <String, dynamic>{
                        "method": "Request Money"
                      })));

      when(mockBeneficiaryBaseApi.getBeneficiaries(method: "Request Money"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(
          await beneficiaryRemoteRepo.getBeneficiary(method: "Request Money"),
          isA<Left<Failure, ParentModel>>());
    });
  });
}
