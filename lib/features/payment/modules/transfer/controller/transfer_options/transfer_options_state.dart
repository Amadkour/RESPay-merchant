part of 'transfer_options_cubit.dart';

abstract class TransferOptionsState {}

class TransferOptionsInitial extends TransferOptionsState {}

class TransferOptionsLoadedState extends TransferOptionsState {}

class TransferOptionsErrorState extends TransferOptionsState {
  final Failure failure;

  TransferOptionsErrorState(this.failure);
}

class TransferOptionsLoadingState extends TransferOptionsState {}

class TransferTypeItemChosen extends TransferOptionsState {}

class NoteTextFieldValueChanged extends TransferOptionsState {}
