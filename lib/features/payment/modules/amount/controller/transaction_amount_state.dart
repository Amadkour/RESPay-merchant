part of 'transaction_amount_cubit.dart';

abstract class TransactionAmountState extends Equatable {
  const TransactionAmountState();

  @override
  List<Object> get props => <Object>[];
}

class TransactionAmountInitial extends TransactionAmountState {}

class AmountTextFieldValueChanged extends TransactionAmountState {}

class TransactionCurrencyChanged extends TransactionAmountState {
  final Currency currency;

  const TransactionCurrencyChanged(this.currency);

  @override
  List<Object> get props => <Object>[currency];
}

class CurrencyLoadError extends TransactionAmountState {
  final Failure failure;

  const CurrencyLoadError(this.failure);
}

class CurrencyLoadingState extends TransactionAmountState {}

class CurrencyLoadedState extends TransactionAmountState {}
