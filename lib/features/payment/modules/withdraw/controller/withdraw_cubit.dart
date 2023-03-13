import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/provider/model/bank_account.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/provider/repository/withdraw_repo.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

part 'withdraw_state.dart';

class WithdrawCubit extends Cubit<WithdrawState> {
  WithdrawCubit() : super(WithdrawLoading()) {
    amountController.addListener(() {
      emit(WithdrawLoaded());
    });
    onInit();
  }

  TextEditingController amountController = TextEditingController();

  List<BankAccounts> bankAccounts = <BankAccounts>[];
  BankAccounts? selectedBankAccount;

  Future<void> onInit() async {
    await getBankAccounts();
  }

  Future<void> getBankAccounts({bool forceLoad = false}) async {
    /// get withdrawRepo class from dependency injection file
    if (forceLoad ||
        (sl<WithdrawRepository>().data.bankAccounts?.isEmpty ?? true)) {
      emit(WithdrawLoading());
      await sl<WithdrawRepository>().getBankAccount();
    }
    bankAccounts =
        sl<WithdrawRepository>().data.bankAccounts ?? <BankAccounts>[];
    emit(WithdrawLoaded());
  }

  void onChangeBank(BankAccounts? value) {
    selectedBankAccount = value;
    emit(BankStateChanged());
  }

  void onClearData() {
    amountController.clear();
    selectedBankAccount = null;
    emit(BankStateChanged());
  }

  Future<ReceiptModel?> withDraw() async {
    // CustomNavigator.instance.pushNamed(verificationMethodPath, arguments: () async {
    //   (await WithdrawRepository().withdraw(
    //     amount: amountController.text,
    //     bankUuid: selectedBankAccountUUID,
    //     walletUUID: sl<TransactionHistoryCubit>().wallet?.uuid ?? "",
    //   ))
    //       .fold((Failure l) {
    //     if (l.errors.isNotEmpty) {
    //       MyToast(l.errors.values.toString());
    //       emit(WithdrawErrorState());
    //     }
    //     // MyToast(l.message.toString());
    //   }, (Map<String, dynamic> r) {
    //     sl<TransactionHistoryCubit>().getWallet();
    //     final Map<String, dynamic> data = r['data'] as Map<String, dynamic>;
    //     CustomSuccessDialog(
    //       context: context,
    //       canClose: true,
    //       title: tr('withdraw_successful'),
    //       subTitle: data['message'] as String,
    //       onPressedFirstButton: () {
    //         ///get selected bank
    //         final BankAccounts? bankAccount =
    //             bankAccounts.firstWhereOrNull((BankAccounts element) => element.uuid == selectedBankAccountUUID);

    //         ///close dialog
    //         CustomNavigator.instance.pop();

    //         /// go to summary
    //         CustomNavigator.instance.push(
    //           routeWidget: TransactionReceiptPage(
    //             transactionTitle: "withdraw",
    //             transactionType: 'withdraw',
    //             amount: amountController.removeNonNumber,
    //             fromWithdraw: true,
    //             withdrawBankName: bankAccount?.bankName,
    //             withdrawBankAccount: bankAccount?.accountNumber,
    //             withdrawIcon: 'assets/icons/saving/withdraw-icon.svg',
    //           ),
    //         );
    //       },
    //       imageUrl: 'assets/images/home/guestDialog.svg',
    //       firstButtonText: tr('View E-Receipt'),
    //     );
    //   });
    // });

    final Either<Failure, ReceiptModel> result =
        await WithdrawRepository().withdraw(
      amount: amountController.removeNonNumber,
      bankUuid: selectedBankAccount?.uuid,
      walletUUID: sl<TransactionHistoryCubit>().wallet?.uuid ?? "",
    );

    return result.fold((Failure l) {
      emit(WithdrawErrorState(l));
      return null;
    }, (ReceiptModel receipt) async {
      await sl<TransactionHistoryCubit>().getWallet();
      return receipt;
    });
  }

  bool get enableButton =>
      amountController.text.isNotEmpty && selectedBankAccount != null;

  @override
  Future<void> close() {
    amountController.dispose();
    return super.close();
  }
}
