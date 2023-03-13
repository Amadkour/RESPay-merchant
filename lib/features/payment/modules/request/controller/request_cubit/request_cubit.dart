import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_state.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/model/money_request_filter_enum.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/model/money_requests_model.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/repos/request_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/created_beneficiary.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

class RequestCubit extends Cubit<RequestState> {
  String? phoneNumberError;
  RequestRemoteRepo? requestRemoteRepo;
  RequestCubit(this.requestRemoteRepo) : super(RequestInitial());

  String currentRequest = "";
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  FocusNode firstNameFocus = FocusNode();
  FocusNode familyNameFocus = FocusNode();
  FocusNode phoneNumberFocus = FocusNode();
  String? categoryErrorMessage;

  List<RequestModel> searchInReceivedRequests(String value) {
    if (state is! RequestLoadingState) {
      if (value.isEmpty) {
        return requests;
      } else {
        return requests
            .where(
                (RequestModel element) => element.senderName!.contains(value))
            .toList();
      }
    }
    return requests;
  }

  List<RequestModel> get requests {
    List<RequestModel> requestsList = <RequestModel>[];
    requestsList = moneyRequestsModel.requests!;
    if (_status == MoneyRequestFilterEnum.sent) {
      requestsList = moneyRequestsModel.requests!
          .where((RequestModel element) => element.isSentByMe)
          .toList();
    } else if (_status != MoneyRequestFilterEnum.allRequests) {
      requestsList = moneyRequestsModel.requests!
          .where((RequestModel element) => element.status == _status)
          .toList();
    }
    return requestsList;
  }

  String? currentCategory;

  int currentTapIndex = 0;

  MoneyRequestFilterEnum _status = MoneyRequestFilterEnum.allRequests;

  MoneyRequestFilterEnum get filterStatus => _status;

  set filterStatus(MoneyRequestFilterEnum status) {
    _status = status;
    emit(RequestsFilterStatusChanged(status));
  }

  ///
  void setCurrentTapIndex(int value) {
    currentTapIndex = value;
    emit(TapIsChanged());
  }

  void setCurrentCategory(String value) {
    currentCategory = value;
    emit(CategoryIsChanged());
  }

  void updateState() {
    if (phoneNumberError != "") {
      phoneNumberError = "";
    }
    emit(RequestInitial());
  }

  bool requestBeneficiaryDataEnabledButton(
      GlobalKey<FormState> requestBeneficiaryValidationFormKey) {
    return requestBeneficiaryValidationFormKey.currentState?.validate() ??
        false;
  }

  bool requestAmountButton(GlobalKey<FormState> requestMoneyValidationFormKey) {
    if (requestMoneyValidationFormKey.currentState != null) {
      return requestMoneyValidationFormKey.currentState!.validate() &&
          currentCategory != null;
    } else {
      return false;
    }
  }

  void resetRequestAmount() {
    noteController.clear();
    amountController.clear();
    categoryErrorMessage = "";
    currentCategory = null;
  }

  void reset({String? phoneNumber}) {
    firstNameController.clear();
    if (phoneNumber == null) {
      phoneNumberController.clear();
    } else {
      phoneNumberController.text = phoneNumber;
    }
    lastNameController.clear();
    phoneNumberError = "";
    emit(RequestInitial());
  }

  void setPhoneNumber(String newPhoneNumber) {
    phoneNumberController.text = newPhoneNumber;
    emit(RequestInitial());
  }

  MoneyRequestsModel moneyRequestsModel =
      MoneyRequestsModel(categories: <String>[], requests: <RequestModel>[]);

  void resetStateAfterNavigate() {
    emit(RequestInitial());
  }

  Future<void> getMoneyRequests() async {
    _status = MoneyRequestFilterEnum.allRequests;
    emit(RequestLoadingState());
    try {
      final Either<Failure, ParentModel> result =
          await requestRemoteRepo!.getMoneyRequests();
      result.fold((Failure l) {
        moneyRequestsModel = MoneyRequestsModel(
            requests: <RequestModel>[], categories: <String>[]);
        emit(GetRequestCategoriesErrorState());
      }, (ParentModel r) async {
        moneyRequestsModel = r as MoneyRequestsModel;
        emit(GetRequestCategoriesDoneState());
      });
    } catch (e) {
      moneyRequestsModel = MoneyRequestsModel(
          requests: <RequestModel>[], categories: <String>[]);
      emit(RequestFailure());
    }
  }

  Future<Beneficiary?> addNewRequestBeneficiary() async {
    Beneficiary? beneficiary;
    emit(RequestLoadingState());
    try {
      final Either<Failure, ParentModel> result = await requestRemoteRepo!
          .addNewRequestBeneficiary(input: <String, dynamic>{
        "phone_number": phoneNumberController.removeNonNumber,
        "type": "internal",
        "method": "Request Money",
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
      });
      result.fold((Failure l) {
        if (l.errors.isNotEmpty) {
          if (l.errors["error"] != null) {
            phoneNumberError = l.errors["error"] as String;
          }
          if (l.errors['phone_number'] != null) {
            phoneNumberError =
                (l.errors["phone_number"] as List<dynamic>).first as String;
          }
        }
        emit(AddNewRequestBeneficiaryErrorState());
      }, (ParentModel r) async {
        phoneNumberError = "";
        beneficiary = (r as CreatedBeneficiaryModel).beneficiary;
        emit(RequestDoneNavigateToTransferMoney());
      });
    } catch (e) {
      emit(RequestFailure());
    }
    return beneficiary;
  }

  Future<void> sendRequestMoney(String uuid) async {
    emit(RequestSendLoadingState());
    try {
      final Either<Failure, ReceiptModel> result =
          await requestRemoteRepo!.requestMoney(input: <String, dynamic>{
        "amount": amountController.removeNonNumber,
        "beneficiary_uuid": uuid,
        "type": "Direct request",
        "category": currentCategory,
        "note": noteController.text,
      });
      result.fold((Failure l) {
        if (l.errors.isNotEmpty) {
          if (l.errors["error"] != null) {
            MyToast(l.errors["error"] as String);
          }
          emit(CategoryErrorState());
        } else {
          emit(RequestMoneyErrorState());
        }
      }, (ReceiptModel r) {
        categoryErrorMessage = null;
        emit(RequestSendSate(r));
        sl<TransactionHistoryCubit>().getWallet();
      });
    } catch (e) {
      emit(RequestMoneyErrorState());
    }
  }

  Future<void> acceptOrRejectRequest(
      {required String requestUUID,
      required MoneyRequestFilterEnum status}) async {
    currentRequest = requestUUID;
    if (status == MoneyRequestFilterEnum.rejected) {
      emit(RequestRejectLoadingState());
    }
    if (status == MoneyRequestFilterEnum.accepted) {
      emit(RequestAcceptanceLoadingState());
    }
    try {
      final Either<Failure, ParentModel> result = await requestRemoteRepo!
          .acceptOrRejectRequest(input: <String, dynamic>{
        "money_request_uuid": requestUUID,
        "status": status,
      });
      result.fold((Failure l) {
        if (l.errors.isNotEmpty) {
          if (l.errors["error"] != null) {
            MyToast(l.errors["error"] as String);
          }
        }
        emit(RequestMoneyErrorState());
      }, (ParentModel r) {
        moneyRequestsModel.requests!
            .where((RequestModel element) => element.uuid == requestUUID)
            .forEach((RequestModel element) {
          element.status = status;
        });
        emit(RequestCubitMoneyRequestsLoaded());
      });
    } catch (e) {
      emit(RequestMoneyErrorState());
      currentRequest = "";
    }
  }

  void resetCubitStateToInitial() {
    _status = MoneyRequestFilterEnum.allRequests;
    emit(RequestInitial());
  }
}
