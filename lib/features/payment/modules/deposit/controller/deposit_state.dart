part of 'deposit_cubit.dart';

abstract class DepositState extends Equatable {
  const DepositState();

  @override
  List<Object> get props => <Object>[];
}

class DepositInitial extends DepositState {}

class DepositLoading extends DepositState {}

class DepositCreated extends DepositState {
  final ReceiptModel receiptModel;

  const DepositCreated(this.receiptModel);
}

class DepositFailure extends DepositState {
  final Failure failure;

  const DepositFailure(this.failure);
}

class DepositCardChanged extends DepositState {}

class DepositAmountChanged extends DepositState {
  final String text;

  const DepositAmountChanged(this.text);
  @override
  List<Object> get props => <Object>[text];
}
