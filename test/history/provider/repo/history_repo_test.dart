// ignore_for_file: always_specify_types

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/api/remote_transaction_api.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/history_filter_input.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/item_transaction_list_model.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/wallet.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/repos/transaction_repo.dart';

import '../history_values.dart';
import 'history_repo_test.mocks.dart';

@GenerateMocks([HistoryApi, HistoryFilterInput])
void main() {
  late MockHistoryApi api;
  late TransactionHistoryRepo repo;
  late Wallet wallet;
  late TransactionListModel history;
  late MockHistoryFilterInput input;
  setUpAll(() {
    api = MockHistoryApi();
    repo = TransactionHistoryRepo(api);
    wallet = Wallet().fromJsonInstance(
            getWalletValues.successfulResponse['data'] as Map<String, dynamic>)
        as Wallet;

    history = TransactionListModel().fromJsonInstance(
            getHistoryValues.successfulResponse['data'] as Map<String, dynamic>)
        as TransactionListModel;
    input = MockHistoryFilterInput();
  });

  group("get wallet method testing", () {
    test("verify that get wallet return Wallet Model", () async {
      when(api.getWallet()).thenAnswer((Invocation realInvocation) async {
        return right(Response<Map<String, dynamic>>(
          data: getWalletValues.successfulResponse,
          statusCode: 200,
          requestOptions: RequestOptions(
            path: getWalletValues.path,
          ),
        ));
      });

      final Either<Failure, ParentModel> result = await repo.get();
      final Object model =
          result.fold((Failure l) => l, (ParentModel r) => r as Wallet);

      expect(model, equals(wallet));
    });
    test("verify that get wallet return failure", () async {
      when(api.getWallet()).thenAnswer((Invocation realInvocation) async {
        return right(Response<Map<String, dynamic>>(
          data: getWalletValues.failureResponse,
          requestOptions: RequestOptions(
            path: getWalletValues.path,
          ),
        ));
      });

      final Either<Failure, ParentModel> result = await repo.get();
      final Object model =
          result.fold((Failure l) => l, (ParentModel r) => r as Wallet);

      expect(model, isA<Failure>());
    });
  });

  group("get transaction history testing", () {
    test("verify that get transaction history return TransactionListModel ",
        () async {
      when(input.toMap()).thenReturn(filterHistoryParams.toMap());
      when(api.getTransactions(
        filters: input,
      )).thenAnswer((Invocation realInvocation) async {
        return right(Response<Map<String, dynamic>>(
          data: getHistoryValues.successfulResponse,
          statusCode: 200,
          requestOptions: RequestOptions(
            path: getHistoryValues.path,
          ),
        ));
      });

      final Either<Failure, ParentModel> result =
          await repo.getTransactions(filters: input);
      final Object model = result.fold(
          (Failure l) => l, (ParentModel r) => r as TransactionListModel);

      expect(model, equals(history));
    });
    test("verify that get history return failure", () async {
      when(input.toMap()).thenReturn(filterHistoryParams.toMap());
      when(api.getTransactions(
        filters: input,
      )).thenAnswer((Invocation realInvocation) async {
        return right(Response<Map<String, dynamic>>(
          data: getHistoryValues.failureResponse,
          requestOptions: RequestOptions(
            path: getHistoryValues.path,
          ),
        ));
      });

      final Either<Failure, ParentModel> result =
          await repo.getTransactions(filters: input);
      final Object model = result.fold(
          (Failure l) => l, (ParentModel r) => r as TransactionListModel);

      expect(model, isA<Failure>());
    });
  });
}
