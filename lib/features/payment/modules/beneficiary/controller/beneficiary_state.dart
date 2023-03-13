part of 'beneficiary_cubit.dart';

@immutable
abstract class BeneficiaryState {
  List<Object?> get props => <Object?>[identityHashCode(this)];
}

class BeneficiaryInitial extends BeneficiaryState {}

class TextFieldValueChanged extends BeneficiaryState {}

class NavigateToAmount extends BeneficiaryState {}

class BeneficiaryLoadingState extends BeneficiaryState {}

class BeneficiaryAddedInServer extends BeneficiaryState {}

class NavigateToSummary extends BeneficiaryState {}

class CurrencyChanged extends BeneficiaryState {}

class FetchAllCurrenciesErrorState extends BeneficiaryState {}

class ValidateForm extends BeneficiaryState {
  @override
  List<Object?> get props => <Object?>[identityHashCode(this)];
}

class CountryChanged extends BeneficiaryState {}

class CountryLoaded extends BeneficiaryState {}

class NavigateToTransferMoney extends BeneficiaryState {}

class BeneficiaryLoadedState extends BeneficiaryState {}

class CorrectConfigurationDone extends BeneficiaryState {}

class CorrectTapIndexAccordingToTransferTypeState extends BeneficiaryState {}

class BeneficiaryCreated extends BeneficiaryState {}

class RelationshipsChanged extends BeneficiaryState {}

class RequiredFieldsExist extends BeneficiaryState {}

class WriteInputState extends BeneficiaryState {}

class TransferToTapIndexChanged extends BeneficiaryState {}

class TapIsChanged extends BeneficiaryState {}

class BeneficiaryCreatedState extends BeneficiaryState {}

class SetNewErrorMessage extends BeneficiaryState {}

class DropDownItemChosen extends BeneficiaryState {}

class SetCurrentBeneficiary extends BeneficiaryState {}

class BeneficiaryFiltered extends BeneficiaryState {
  @override
  List<Object?> get props => <Object?>[identityHashCode(this)];
}

class WalletNameValueChanged extends BeneficiaryState {
  @override
  List<Object?> get props => <Object>[identityHashCode(this)];
}

class ResetWalletNameFields extends BeneficiaryState {
  @override
  List<Object?> get props => <Object>[identityHashCode(this)];
}

class BeneficiaryGetAllState extends BeneficiaryState {}

class ResetBeneficiaryFields extends BeneficiaryState {}

class BeneficiaryAddedToFavourite extends BeneficiaryState {}

class BeneficiaryRemovedFromFavourite extends BeneficiaryState {}

class FavouriteToggleLoading extends BeneficiaryState{}
class FavouriteToggleLoaded extends BeneficiaryState{}

/// API FAILURES STATES
class FetchAllBeneficiariesErrorState extends BeneficiaryState {}

class FetchRequestBeneficiariesErrorState extends BeneficiaryState {}

class FetchGiftBeneficiariesErrorState extends BeneficiaryState {}

class AddNewTransferBeneficiaryErrorState extends BeneficiaryState {}

class InvalidData extends BeneficiaryState {}

class CountriesError extends BeneficiaryState {}

class SearchBarClearSate extends BeneficiaryState {}

class FavouriteToggleError extends BeneficiaryState{}
class DeleteBeneficiry extends BeneficiaryState{}
class BeneficiaryFailure extends BeneficiaryState{}
