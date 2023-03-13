part of 'gift_cubit.dart';

@immutable
abstract class GiftState {}

class NewGiftInitial extends GiftState {}

class TapIsChanged extends GiftState {}

class GiftRequiredFieldsExist extends GiftState {}

class NavigateToTransferMoney extends GiftState {}

class GiftRequestTextFieldChanged extends GiftState {}

class GiftLoadingState extends GiftState {}

class SendGiftLoadingState extends GiftState {}

class GetGiftLoadingState extends GiftState {}

class GetGiftLoadedState extends GiftState {}

class GiftLoadedState extends GiftState {}

class AllFieldsIsClear extends GiftState {}

class GiftCategoryIsChanged extends GiftState {}

class PurposeItemChosen extends GiftState {}

class ValidateGiftRequestDataDoneInSuccess extends GiftState {}

class ValidateGiftBeneficiaryDataDoneInSuccess extends GiftState {}

class GiftSendSate extends GiftState {
  final ReceiptModel receiptModel;

  GiftSendSate(this.receiptModel);
}

class GiftBeneficiaryInitiated extends GiftState {}

class GiftRequestSendSate extends GiftState {}

/// API FAILURES STATES
class AddNewGiftBeneficiaryErrorState extends GiftState {}

class SendGiftErrorState extends GiftState {}

class GetGiftErrorState extends GiftState {}

class GiftSendError extends GiftState {}
