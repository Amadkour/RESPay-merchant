// ignore_for_file: always_specify_types

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/provider/api/deposit_api.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/provider/repo/deposit_repo.dart';

import '../deposit_values.dart';
import 'deposit_repo_test.mocks.dart';

@GenerateMocks([DepositRemoteApi])
void main() {
  late MockDepositRemoteApi api;
  late DepositRepo repo;

  setUpAll(() {
    api = MockDepositRemoteApi();
    repo = DepositRepo(api);
  });

  group("test deposit repo", () {
    test('verify that deposit repo create method return success', () async {
      when(api.createDeposit(makeDepositParams)).thenAnswer((Invocation realInvocation) async {
        return right(Response<Map<String, dynamic>>(
            data: depositValues.successfulResponse,
            requestOptions: RequestOptions(
              path: depositValues.path,
            )));
      });

      final result = await repo.create(makeDepositParams);
      expect(result, isA<Right>());
    });

    test('verify that deposit repo create method return failure', () async {
      when(api.createDeposit(makeDepositParams)).thenAnswer((Invocation realInvocation) async {
        return left(ApiFailure(errors: {"": "server failure"}));
      });

      final result = await repo.create(makeDepositParams);
      expect(result, isA<Left>());
    });
  });
}
