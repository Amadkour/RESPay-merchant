// ignore_for_file: always_specify_types

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/controller/deposit_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/provider/repo/deposit_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/wallet.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

import '../../cards/provider/card_values.dart';
import '../../history/provider/history_values.dart';
import '../provider/deposit_values.dart';
import 'deposit_controller_test.mocks.dart';

@GenerateMocks([DepositRepo, TransactionHistoryCubit])
void main() {
  late MockDepositRepo repo;
  late MockTransactionHistoryCubit cubit;

  setUp(() {
    repo = MockDepositRepo();
    cubit = MockTransactionHistoryCubit();
  });

  group("deposit cubit testing", () {
    blocTest<DepositCubit, DepositState>(
      'emits [DepositLoading,DepositCreated] when create method return none',
      setUp: () {
        when(cubit.wallet).thenReturn(wallet as Wallet);
        when(repo.create(makeDepositParams)).thenAnswer(
          (realInvocation) async {
            return right(
                ReceiptModel.fromJson(depositValues.successfulResponse['data'] as Map<String, dynamic>, 'deposit'));
          },
        );
      },
      skip: 1,
      build: () {
        return DepositCubit(
          repo: repo,
          cubit: cubit,
        );
      },
      act: (bloc) {
        bloc.card = cardModel;
        bloc.amountController.text = "500";
        return bloc.create();
      },
      expect: () => [isA<DepositLoading>(), isA<DepositCreated>()],
    );
    blocTest<DepositCubit, DepositState>(
      'emits [DepositLoading,DepositFailure] when create method is returned some ',
      setUp: () {
        when(cubit.wallet).thenReturn(wallet as Wallet);
        when(repo.create(makeDepositParams)).thenAnswer((realInvocation) async => left(ServerFailure()));
      },
      skip: 1,
      build: () {
        return DepositCubit(
          repo: repo,
          cubit: cubit,
        );
      },
      act: (bloc) {
        bloc.card = cardModel;
        bloc.amountController.text = "500";
        return bloc.create();
      },
      expect: () => [isA<DepositLoading>(), isA<DepositFailure>()],
    );
  });
}
