import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/provider/model/received_gift_model.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/provider/repos/gift_repo/gift_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/created_beneficiary.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer_category.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

part 'gift_state.dart';

class GiftCubit extends Cubit<GiftState> {
  GiftRepository? giftRepository;

  GiftCubit(this.giftRepository) : super(NewGiftInitial());

  bool get isEmpty => false;

  TextEditingController amountController = TextEditingController();

  TextEditingController phoneNumberController = TextEditingController();
  FocusNode phoneNumberFocus = FocusNode();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController giftTitleController = TextEditingController();
  FocusNode giftTitleFocus = FocusNode();
  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  TextEditingController recipientNameController = TextEditingController();
  FocusNode recipientNameFocus = FocusNode();
  String phoneNumberError = "";
  TransferCategoryModel? currentCategory;
  TodayGifts todayGifts = TodayGifts(receivedGiftModels: <ReceivedGiftModel>[]);
  String? currentPurpose;

  void resetSendMoneyData() {
    noteController.clear();
    amountController.clear();
    errorMessage = null;
    currentCategory = null;
    currentPurpose = null;
  }

  void reset() {
    firstNameController.clear();
    lastNameController.clear();
    phoneNumberController.clear();
    giftTitleController.clear();
    phoneNumberError = "";
    recipientNameController.clear();
    emit(AllFieldsIsClear());
  }

  void updateState() {
    if (phoneNumberError != "") {
      phoneNumberError = "";
    }
    emit(NewGiftInitial());
  }

  String? errorMessage;

  bool isEnabled(GlobalKey<FormState> beneficiaryValidationFormKey) {
    if (beneficiaryValidationFormKey.currentState != null) {
      return beneficiaryValidationFormKey.currentState!.validate();
    } else {
      return false;
    }
  }

  bool giftAmountRequestButton(GlobalKey<FormState> sendGiftValidationFormKey) {
    if (sendGiftValidationFormKey.currentState != null) {
      return sendGiftValidationFormKey.currentState!.validate() &&
          currentCategory != null &&
          currentPurpose != null;
    } else {
      return false;
    }
  }

  void setCurrentCategory(TransferCategoryModel value) {
    currentCategory = value;
    emit(GiftCategoryIsChanged());
  }

  void setCurrentPurpose(String value) {
    currentPurpose = value;
    emit(PurposeItemChosen());
  }

  int currentTapIndex = 0;

  ///
  void setCurrentTapIndex(int value) {
    currentTapIndex = value;
    emit(TapIsChanged());
  }

  List<ReceivedGiftModel> searchInReceivedGifts(String name) {
    if (name == "") {
      return todayGifts.receivedGiftModels!;
    }
    return todayGifts.receivedGiftModels!
        .where((ReceivedGiftModel element) => element.gift!.contains(name))
        .toList();
  }

  ///
  void resetStateAfterNavigate() {
    emit(NewGiftInitial());
  }

//////
  Future<Beneficiary?> addNewGiftBeneficiary() async {
    emit(GiftLoadingState());
    Beneficiary? beneficiary;
    try {
      final Either<Failure, ParentModel> result =
          await giftRepository!.addNewGiftBeneficiary(input: <String, dynamic>{
        "phone_number": phoneNumberController.text,
        "type": "internal",
        "method": "Gift",
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
          emit(AddNewGiftBeneficiaryErrorState());
        }
      }, (ParentModel r) {
        phoneNumberError = "";
        errorMessage = null;
        emit(GiftBeneficiaryInitiated());
        beneficiary = (r as CreatedBeneficiaryModel).beneficiary;
      });
    } catch (e) {
      errorMessage = "sever error addNewGiftBeneficiary gift_cubit.dart - 156 ";
      emit(AddNewGiftBeneficiaryErrorState());
    }
    return beneficiary;
  }

  Future<ReceiptModel?> sendGift(String uuid) async {
    try {
      emit(SendGiftLoadingState());
      final Either<Failure, ReceiptModel> result =
          await giftRepository!.sendGift(
        input: <String, dynamic>{
          "amount": amountController.removeNonNumber,
          "beneficiary_uuid": uuid,
          "purpose": currentPurpose,
          "category": currentCategory!.uuid,
          "note": noteController.text,
        },
      );
      return result.fold((Failure l) {
        if (l.errors.isNotEmpty) {
          if (l.errors["error"] != null) {
            errorMessage = l.errors["error"] as String;
          } else {
            errorMessage = "Server Error Happen";
          }
          MyToast(errorMessage!);
          emit(SendGiftErrorState());
        }
        return null;
      }, (ReceiptModel r) {
        emit(GiftSendSate(r));
        sl<TransactionHistoryCubit>().getWallet();
        return r;
      });
    } catch (x) {
      errorMessage = "sever error sendGift gift_cubit.dart - 189";
      MyToast(errorMessage!);
      emit(SendGiftErrorState());
    }
    return null;
  }

  Future<void> getReceiveGifts() async {
    emit(GetGiftLoadingState());

    try {
      final Either<Failure, TodayGifts> result =
          await giftRepository!.receiveGiftsRepository();
      result.fold((Failure l) {
        if (l.errors.isNotEmpty) {
          if (l.errors["error"] != null) {
            errorMessage = l.errors["error"] as String;
          } else {
            errorMessage = "Server Error Happen";
          }
          MyToast(errorMessage!);
          emit(GetGiftErrorState());
        }
      }, (TodayGifts r) {
        todayGifts = r;
        emit(GetGiftLoadedState());
      });
    } catch (x) {
      errorMessage = "sever error getReceiveGifts gift_cubit.dart - 218";
      MyToast(errorMessage!);
      emit(GetGiftLoadedState());
    }
  }
}
