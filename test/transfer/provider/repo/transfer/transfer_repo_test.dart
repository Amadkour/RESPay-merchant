// ignore_for_file: always_specify_types, duplicate_ignore

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/transfer/transfer_remote_api.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/repos/transfer/transfer_repo.dart';

import '../../transfer_values.dart';
import 'transfer_repo_test.mocks.dart';

@GenerateMocks([TransferRemoteApi])
void main() {
  late MockTransferRemoteApi api;
  late TransferRepo repo;

  setUpAll(() {
    api = MockTransferRemoteApi();
    repo = TransferRepo(api);
  });

  group('transfer repo testing', () {
    test('verify that make transfer method success ', () async {
      when(
        api.createTransfer(createTransferInput),
      ).thenAnswer((Invocation realInvocation) async {
        return right(
          Response<Map<String, dynamic>>(
            data: makeTransferValues.successfulResponse,
            requestOptions: RequestOptions(
              path: makeTransferValues.path,
            ),
          ),
        );
      });
      final result = await repo.create(createTransferInput);
      // ignore: always_specify_types
      expect(result, isA<Right>());
    });

    test('verify that make transfer method failed ', () async {
      when(
        api.createTransfer(createTransferInput),
      ).thenAnswer((Invocation realInvocation) async {
        return left(ApiFailure(errors: <String, String>{"": "server exception"}));
      });
      final result = await repo.create(createTransferInput);
      expect(result, isA<Left>());
    });
  });
}
