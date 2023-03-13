import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/beneficiary/beneficiary_remote_api.dart';

import '../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../beneficiary_values.dart';

void main() {
  late MockDio mockedDio;
  late BeneficiaryRemoteApi api;

  setUpAll(() {
    mockedDio = MockDio();
    api = BeneficiaryRemoteApi.withDio(dio: mockedDio);
  });
  group("New Transfer Beneficiary Api", () {
    test('New Transfer Beneficiary Api Test', () async {
      when(mockedDio.post(addNewTransferBeneficiaryValues.path, data: anything)).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: addNewTransferBeneficiaryValues.successfulResponse,
          requestOptions: RequestOptions(
            path: addNewTransferBeneficiaryValues.path,
          ),
        ),
      );
      expect(await api.createTransferBeneficiary(inputs: successAddNewTransferBeneficiaryInput),
          isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('New Transfer Beneficiary Api Failed Test', () async {
      when(mockedDio.post(addNewTransferBeneficiaryValues.path, data: addNewTransferBeneficiaryValues.failureBody))
          .thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: addNewTransferBeneficiaryValues.failureResponse,
          requestOptions: RequestOptions(
            path: addNewTransferBeneficiaryValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result =
          await api.createTransferBeneficiary(inputs: failureAddNewTransferBeneficiaryInput);
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  ////////////////////////////////////////////////////////

  group("Get Transfer Beneficiaries Api", () {
    test('Get Transfer Beneficiaries Api Test', () async {
      when(mockedDio.get(getAllTransferBeneficiariesValues.path, queryParameters: <String, dynamic>{})).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 200,
          data: getAllTransferBeneficiariesValues.successfulResponse,
          requestOptions:
              RequestOptions(path: getAllTransferBeneficiariesValues.path, queryParameters: <String, dynamic>{}),
        ),
      );
      expect(await api.getBeneficiaries(), isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('Get All Transfer Beneficiaries Api Failed Test', () async {
      when(mockedDio.get(getAllTransferBeneficiariesValues.path, queryParameters: <String, dynamic>{}))
          .thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: getAllTransferBeneficiariesValues.failureResponse,
          requestOptions:
              RequestOptions(path: getAllTransferBeneficiariesValues.path, queryParameters: <String, dynamic>{}),
        );
      });
      expect(await api.getBeneficiaries(), isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
