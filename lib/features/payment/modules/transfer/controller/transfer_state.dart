part of 'transfer_cubit.dart';

abstract class TransferState {
  const TransferState();
}

class TransferInitial extends TransferState {}

class TransferLoadingState extends TransferState {}

class TransferErrorState extends TransferState {
  final Failure failure;

  const TransferErrorState(this.failure);
}

class TransferCreatedState extends TransferState {}

class TransferGetAllState extends TransferState {}

class TransferCountryChanged extends TransferState {
  final Currency country;

  const TransferCountryChanged(this.country);
}

class TransferCategoryChanged extends TransferState {
  final TransferCategoryModel category;

  TransferCategoryChanged(this.category);
}

class TransferPurposeChanged extends TransferState {
  final String purpose;

  const TransferPurposeChanged(this.purpose);
}

class TransferAmountChanged extends TransferState {
  final String amount;

  TransferAmountChanged(this.amount);
}

/// API FAILURES STATES
class FetchTransfersListErrorState extends TransferState {}
