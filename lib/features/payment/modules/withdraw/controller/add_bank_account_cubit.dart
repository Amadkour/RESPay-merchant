import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/provider/repository/add_bank_repo.dart';

part 'add_bank_account_state.dart';

class AddBankAccountCubit extends Cubit<AddBankAccountState> {
  AddBankAccountCubit() : super(AddBankAccountInitial()) {
    // fullNameController.addListener(() {
    //   emit(CreateAccountLoaded());
    // });
    // accountNumberController.addListener(() {
    //   emit(CreateAccountLoaded());
    // });
    // ibanController.addListener(() {
    //   emit(CreateAccountLoaded());
    // });
  }

  // final TextEditingController fullNameController = TextEditingController();
  // final TextEditingController accountNumberController = TextEditingController();
  // final TextEditingController ibanController = TextEditingController();

  ///----- Focus Nodes
  // FocusNode fullNameFocusNode = FocusNode();
  // FocusNode accountNumberFocusNode = FocusNode();
  // FocusNode ibanFocusNode = FocusNode();

  ///----- Errors
  String fullNameError = '';
  String accountNumberError = '';
  String ibanError = '';

  ///----fields
  String fullName = '';
  String accountNumber = '';
  String iBan = '';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<bool> createAccount() async {
    emit(CreateAccountLoading());
    return (await AddBankRepo().createAccount(
      iBan: iBan,
      accountNum: accountNumber.replaceAll('-', ''),
      ownerName: fullName,
    ))
        .fold(() {
      // sl<WithdrawCubit>().bankAccounts.add(
      //       BankAccounts(
      //         '-1',
      //         '-1',
      //         iBan,
      //         accountNumber,
      //         sl<BankNameCubit>().currentBankName!.name,
      //       ),
      //     );

      emit(CreateAccountLoaded());
      return true;
    }, (Failure failure) {
      MyToast(failure.errors.values.toString());
      emit(CreateAccountError());
      return false;
    });
  }

  void onNameChanged(String value) {
    fullName = value;
    emit(BankAccountInfoChanged());
  }

  void onAccountNumberChanged(String value) {
    accountNumber = value;
    emit(BankAccountInfoChanged());
  }

  void onIBanChanged(String value) {
    iBan = value;
    emit(BankAccountInfoChanged());
  }

  bool get enableButton {
    // return fullName.isNotEmpty && iBan.isNotEmpty && accountNumber.isNotEmpty && sl<BankNameCubit>().currentBankName != null;
    return formKey.currentState?.validate() ?? false;
  }
}
