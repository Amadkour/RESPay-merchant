import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/provider/api/bank_name/bank_name_remote_api.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/provider/repos/bank_name/bank_name_repo.dart';

import '../../bank_name_values.dart';
import 'bank_name_repo_test.mocks.dart';

@GenerateMocks(<Type>[
  BankNameRemoteApi
])

void main() {
  late MockBankNameRemoteApi mockBankNameRemoteApi;

  late BankNameRemoteRepo bankNameRemoteRepo;

  setUpAll(() {
    mockBankNameRemoteApi = MockBankNameRemoteApi();
    bankNameRemoteRepo = BankNameRemoteRepo(mockBankNameRemoteApi);
  });

  group('Get Bank Names test', () {

    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
      Right<Failure, Response<Map<String, dynamic>>>(Response<Map<String,dynamic>>(
          data: bankNamesValue.successfulResponse,
          statusCode: 201,
          requestOptions: RequestOptions(path: bankNamesValue.path)
      ));

      when(mockBankNameRemoteApi.getAllBankNames())
          .thenAnswer((Invocation realInvocation) async => response
      );
      expect(
          await bankNameRemoteRepo.getAllBankNames(),
          isA<Right<Failure,ParentModel>>());
    });

    test('test on fail', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
      Right<Failure, Response<Map<String, dynamic>>>(Response<Map<String,dynamic>>(
          data: bankNamesValue.failureResponse,
          statusCode: 404,
          requestOptions: RequestOptions(path: bankNamesValue.path)
      ));

      when(mockBankNameRemoteApi.getAllBankNames())
          .thenAnswer((Invocation realInvocation) async => response
      );
      expect(
          await bankNameRemoteRepo.getAllBankNames(),
          isA<Left<Failure, ParentModel>>());
    });
  });
}
