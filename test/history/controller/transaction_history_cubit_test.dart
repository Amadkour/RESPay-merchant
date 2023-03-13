// ignore_for_file: always_specify_types

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/history_filter_input.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/repos/transaction_repo.dart';

import '../provider/history_values.dart';
import 'transaction_history_cubit_test.mocks.dart';

@GenerateMocks([TransactionHistoryRepo])
void main() {
  late MockTransactionHistoryRepo repo;
  late HistoryCategoryFilterInput categoryFilter;

  final serverFailure = ServerFailure();
  setUpAll(() {
    repo = MockTransactionHistoryRepo();
    categoryFilter = HistoryCategoryFilterInput("123");
  });

  group("getWallet method test", () {
    blocTest<TransactionHistoryCubit, TransactionHistoryState>(
        "verify that getWallet method emits proper WalletLoaded state",
        setUp: () {
          when(repo.get()).thenAnswer((Invocation realInvocation) async {
            return right(wallet);
          });
        },
        build: () => TransactionHistoryCubit(repo: repo),
        act: (TransactionHistoryCubit bloc) => bloc.getWallet(),
        expect: () => [isA<WalletLoading>(), isA<WalletLoaded>()],
        verify: (_) => verify(repo.get()).called(1));
    blocTest<TransactionHistoryCubit, TransactionHistoryState>(
        "verify that getWallet method emits proper WalletFailure state",
        setUp: () {
          when(repo.get()).thenAnswer((Invocation realInvocation) async {
            return left(serverFailure);
          });
        },
        build: () => TransactionHistoryCubit(repo: repo),
        act: (TransactionHistoryCubit bloc) => bloc.getWallet(),
        expect: () => [isA<WalletLoading>(), isA<WalletFailure>()],
        verify: (_) => verify(repo.get()).called(1));
  });

  group("getAllTransactions test", () {
    blocTest<TransactionHistoryCubit, TransactionHistoryState>(
        "verify that getAllTransactions method emits proper TransactionHistoryLoaded state",
        setUp: () {
          when(repo.getTransactions()).thenAnswer((Invocation realInvocation) async {
            return right(history);
          });
        },
        build: () => TransactionHistoryCubit(repo: repo),
        act: (TransactionHistoryCubit bloc) => bloc.getAllTransactions(),
        expect: () => [isA<TransactionHistoryLoading>(), isA<TransactionHistoryLoaded>()],
        verify: (_) => verify(repo.getTransactions()).called(1));
    blocTest<TransactionHistoryCubit, TransactionHistoryState>(
        "verify that getAllTransactions method emits proper TransactionHistoryError state",
        setUp: () {
          when(repo.getTransactions()).thenAnswer((Invocation realInvocation) async {
            return left(serverFailure);
          });
        },
        build: () => TransactionHistoryCubit(repo: repo),
        act: (TransactionHistoryCubit bloc) => bloc.getAllTransactions(),
        expect: () => [isA<TransactionHistoryLoading>(), isA<TransactionHistoryError>()],
        verify: (_) => verify(repo.getTransactions()).called(1));
  });

  group("filterByCategory test", () {
    blocTest<TransactionHistoryCubit, TransactionHistoryState>(
      "verify that filterByCategory method emits proper TransactionHistoryLoaded state",
      setUp: () {
        when(repo.getTransactions(filters: categoryFilter)).thenAnswer((Invocation realInvocation) async {
          return right(history);
        });
      },
      build: () => TransactionHistoryCubit(repo: repo),
      act: (TransactionHistoryCubit bloc) {
        bloc.setCategory("123");
        return bloc.filterByCategory();
      },
      expect: () => [isA<TransactionHistoryLoading>(), isA<TransactionHistoryLoaded>()],
      verify: (_) => verify(repo.getTransactions(filters: categoryFilter)).called(1),
    );
    blocTest<TransactionHistoryCubit, TransactionHistoryState>(
        "verify that filterByCategory method emits proper TransactionHistoryError state",
        setUp: () {
          when(repo.getTransactions(filters: categoryFilter)).thenAnswer((Invocation realInvocation) async {
            return left(serverFailure);
          });
        },
        build: () => TransactionHistoryCubit(repo: repo),
        act: (TransactionHistoryCubit bloc) {
          bloc.setCategory("123");
          return bloc.filterByCategory();
        },
        expect: () => [isA<TransactionHistoryLoading>(), isA<TransactionHistoryError>()],
        verify: (_) => verify(repo.getTransactions(filters: categoryFilter)).called(1));
    blocTest<TransactionHistoryCubit, TransactionHistoryState>(
        "verify that filterByCategory method emits proper TransactionHistoryError state when category not set",
        build: () => TransactionHistoryCubit(repo: repo),
        act: (TransactionHistoryCubit bloc) {
          return bloc.filterByCategory();
        },
        expect: () => [isA<TransactionHistoryLoading>(), isA<TransactionHistoryError>()],
        verify: (_) => verifyNever(repo.getTransactions(filters: categoryFilter)));
  });

  group("filterByPeriod test", () {
    blocTest<TransactionHistoryCubit, TransactionHistoryState>(
      "verify that filterByPeriod method emits proper TransactionHistoryLoaded state",
      setUp: () {
        when(repo.getTransactions(filters: filterHistoryParams)).thenAnswer((Invocation realInvocation) async {
          return right(history);
        });
      },
      build: () => TransactionHistoryCubit(repo: repo),
      act: (TransactionHistoryCubit bloc) {
        bloc.from.text = "18/01/2023";
        bloc.to.text = "19/01/2023";
        bloc.period = "weekly";

        return bloc.filterByPeriod();
      },
      expect: () => [isA<TransactionHistoryLoading>(), isA<TransactionHistoryLoaded>()],
      verify: (_) => verify(repo.getTransactions(filters: filterHistoryParams)).called(1),
    );
    blocTest<TransactionHistoryCubit, TransactionHistoryState>(
      "verify that filterByPeriod method emits proper TransactionHistoryError state",
      setUp: () {
        when(repo.getTransactions(filters: filterHistoryParams)).thenAnswer((Invocation realInvocation) async {
          return left(serverFailure);
        });
      },
      build: () => TransactionHistoryCubit(repo: repo),
      act: (TransactionHistoryCubit bloc) {
        bloc.from.text = "18/01/2023";
        bloc.to.text = "19/01/2023";
        bloc.period = "weekly";

        return bloc.filterByPeriod();
      },
      expect: () => [isA<TransactionHistoryLoading>(), isA<TransactionHistoryError>()],
      verify: (_) => verify(repo.getTransactions(filters: filterHistoryParams)).called(1),
    );

    blocTest<TransactionHistoryCubit, TransactionHistoryState>(
      "verify that filterByPeriod method emits proper TransactionHistoryError state when data not set",
      build: () => TransactionHistoryCubit(repo: repo),
      act: (TransactionHistoryCubit bloc) {
        return bloc.filterByPeriod();
      },
      expect: () => [isA<TransactionHistoryLoading>(), isA<TransactionHistoryError>()],
      verify: (_) => verifyNever(repo.getTransactions(filters: filterHistoryParams)),
    );
  });

  group("history setters test", () {
    blocTest<TransactionHistoryCubit, TransactionHistoryState>(
      "verify that setPeriod method emits proper HistoryPeriodChanged state",
      build: () => TransactionHistoryCubit(repo: repo),
      act: (TransactionHistoryCubit bloc) => bloc.setPeriod("weekly"),
      expect: () => [isA<HistoryPeriodChanged>()],
      verify: (bloc) => expect(bloc.period, "weekly"),
    );
    blocTest<TransactionHistoryCubit, TransactionHistoryState>(
      "verify that setCategory method sets value successfully",
      build: () => TransactionHistoryCubit(repo: repo),
      act: (TransactionHistoryCubit bloc) => bloc.setCategory("123"),
      verify: (bloc) => expect(bloc.filterCategory, "123"),
    );
  });
}
