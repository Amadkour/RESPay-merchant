part of 'add_bank_account_cubit.dart';

@immutable
abstract class AddBankAccountState {}

class AddBankAccountInitial extends AddBankAccountState {}

class CreateAccountLoading extends AddBankAccountState {}

class CreateAccountLoaded extends AddBankAccountState {}

class CreateAccountError extends AddBankAccountState {}

class BankAccountInfoChanged extends AddBankAccountState {}
