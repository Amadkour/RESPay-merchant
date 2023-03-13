part of 'bank_name_cubit.dart';

@immutable
abstract class BankNameState {}

class BankNameInitial extends BankNameState {}

class BankNameValueChanged extends BankNameState {}
class BankNamesLoadingState extends BankNameState {}
class BankNameErrorState extends BankNameState {}
class BankNameLoadedState extends BankNameState {}
