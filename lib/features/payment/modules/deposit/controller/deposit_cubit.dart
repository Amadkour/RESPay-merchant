import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/provider/model/create_deposit_input.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/provider/repo/deposit_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

part 'deposit_state.dart';

class DepositCubit extends Cubit<DepositState> {
  DepositCubit({
    DepositRepo? repo,
    TransactionHistoryCubit? cubit,
  }) : super(DepositInitial()) {
    _repo = repo ?? sl<DepositRepo>();
    _historyCubit = cubit ?? sl<TransactionHistoryCubit>();
    amountController.addListener(
      () {
        emit(DepositAmountChanged(amountController.text));
      },
    );
  }
  late DepositRepo _repo;
  late TransactionHistoryCubit _historyCubit;
  CreditCardModel? card;
  final TextEditingController amountController = TextEditingController();
  bool get buttonEnabled => amountController.text.isNotEmpty && card != null;

  Future<bool> create() async {
    emit(DepositLoading());
    final CreateDepositInput input = CreateDepositInput(
      walletUUID: _historyCubit.wallet?.uuid ?? "",
      cardUUID: card!.uuid,
      type: "credit_card",
      amount: amountController.text.replaceAll(',', ''),
    );
    final Either<Failure, ReceiptModel> result = await _repo.create(input);
    return result.fold((Failure a) {
      emit(DepositFailure(a));
      return false;
    }, (ReceiptModel receiptModel) async {
      emit(DepositCreated(receiptModel));

      await _historyCubit.init();
      return true;
    });
  }

  void setCard(CreditCardModel card) {
    this.card = card;
    emit(DepositCardChanged());
  }

  @override
  Future<void> close() {
    amountController.dispose();
    return super.close();
  }
}
