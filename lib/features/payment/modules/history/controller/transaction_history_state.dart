part of 'transaction_history_cubit.dart';

abstract class TransactionHistoryState {
  const TransactionHistoryState();
}

class TransactionHistoryInitial extends TransactionHistoryState {}

class TransactionHistoryLoaded extends TransactionHistoryState {}

class TransactionHistoryLoading extends TransactionHistoryState {}

class TransactionHistoryError extends TransactionHistoryState {
  final Failure failure;

  TransactionHistoryError(this.failure);
}

class TransactionTypeFilterChanged extends TransactionHistoryState {
  final TransactionTypeModel type;

  const TransactionTypeFilterChanged(this.type);
}

class HistoryPeriodChanged extends TransactionHistoryState {
  final String? period;

  HistoryPeriodChanged(this.period);
}

class TransactionSearchedState extends TransactionHistoryState {
  final List<TransactionModel> transactions;

  TransactionSearchedState(this.transactions);
}

class WalletLoading extends TransactionHistoryState {}

class WalletLoaded extends TransactionHistoryState {}

class WalletFailure extends TransactionHistoryState {
  final Failure failure;

  const WalletFailure(this.failure);
}
