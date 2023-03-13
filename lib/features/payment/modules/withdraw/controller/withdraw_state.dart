part of 'withdraw_cubit.dart';

@immutable
abstract class WithdrawState {}

class WithdrawInitial extends WithdrawState {}

class WithdrawLoaded extends WithdrawState {}

class WithdrawLoading extends WithdrawState {}

class BankStateChanged extends WithdrawState {}

class WithdrawErrorState extends WithdrawState {
  final Failure failure;

  WithdrawErrorState(this.failure);
}

class WithdrawChangeAmount extends WithdrawState {}

class BankAccountLoaded extends WithdrawState {}
