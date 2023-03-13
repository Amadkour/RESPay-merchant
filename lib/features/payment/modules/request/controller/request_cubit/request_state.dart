import 'package:equatable/equatable.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/country.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/model/money_request_filter_enum.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

abstract class RequestState {}

class RequestInitial extends RequestState {}

class CategoryChanged extends RequestState {}

class RequestTextFieldValueChanged extends RequestState {}

class DataVerificationDone extends RequestState {}

class CategoryIsChanged extends RequestState {}

class TransferCountryChanged extends RequestState {
  final Country country;

  TransferCountryChanged(this.country);
  List<Object> get props => <Object>[country];
}

class RequestRequiredFieldsExist extends RequestState {}

class TapIsChanged extends RequestState {}

class RequestsFilterStatusChanged extends RequestState with EquatableMixin {
  final MoneyRequestFilterEnum status;

  RequestsFilterStatusChanged(this.status);
  @override
  List<Object?> get props => <Object?>[status];
}

class RequestMoneyDataVerificationDone extends RequestState {}

class RequestsSearched extends RequestState {}

class RequestLoadingState extends RequestState {}

class RequestSendLoadingState extends RequestState {}

class RequestDoneNavigateToTransferMoney extends RequestState {}

class GetRequestCategoriesErrorState extends RequestState {}

class GetRequestCategoriesDoneState extends RequestState {}

class ResetRequestFields extends RequestState {}

class RequestedBeneficiaryInitiated extends RequestState {}

class RequestCubitMoneyRequestsLoaded extends RequestState {}

class RequestAcceptanceLoadingState extends RequestState {}

class RequestRejectLoadingState extends RequestState {}

class RequestSendSate extends RequestState {
  final ReceiptModel receipt;

  RequestSendSate(this.receipt);
}

/// API FAILURES STATES
class AddNewRequestBeneficiaryErrorState extends RequestState {}

class RequestFailure extends RequestState {}

class RequestMoneyErrorState extends RequestState {}

class CategoryErrorState extends RequestState {}
