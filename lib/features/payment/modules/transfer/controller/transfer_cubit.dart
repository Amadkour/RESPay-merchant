import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/currency.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/category/controller/cubit/category_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_options/transfer_options_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer_category.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer_create_input.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer_options_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/repos/transfer/transfer_repo.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

part 'transfer_state.dart';

class TransferCubit extends Cubit<TransferState> {
  TransferCubit() : super(TransferInitial()) {
    init();
    amountController.addListener(() {
      emit(TransferAmountChanged(amountController.text));
    });
  }
  final TransferRepo _repo = sl<TransferRepo>();
  String? purpose;
  String? note;
  TransferCategoryModel? category;
  final TransferOptionsCubit transferOptions = sl<TransferOptionsCubit>();
  final CategoryCubit categories = sl<CategoryCubit>();

  final TextEditingController amountController = TextEditingController();

  bool makeTransferButtonEnable({required bool isInternal}) {
    if (isInternal) {
      return amountController.text.isNotEmpty && purpose != null && category != null && note?.isNotEmpty == true;
    } else {
      return amountController.text.isNotEmpty && purpose != null;
    }
  }

  ///This Function responsible to get transfer options
  ///and initialize transfer purpose and transfer category
  ///with first items in returned list
  void init() {
    (transferOptions.get()).then((Option<TransferOptionsModel> value) {
      value.fold(() => null, (TransferOptionsModel a) {
        if (a.transferPurposes!.isNotEmpty) {
          changePurpose(a.transferPurposes!.first);
          if (a.transferCategories?.isNotEmpty == true) {
            changeCategory(a.transferCategories!.first);
          }
        }
      });
    });
  }

  void changePurpose(String? purpose) {
    this.purpose = purpose;
    emit(TransferPurposeChanged(purpose!));
  }

  void onNoteChange(String note) {
    this.note = note;
    emit(TransferInitial());
  }

  void changeCategory(TransferCategoryModel category) {
    this.category = category;
    emit(TransferCategoryChanged(category));
  }

  ///this function responsible to
  ///create new transfer and call wallet api
  ///again to make sure that the latest transactions loaded
  Future<ReceiptModel?> createTransfer(String uuid) async {
    emit(TransferLoadingState());
    final CreateTransferInput inputs = CreateTransferInput(
      amount: amountController.removeNonNumber,
      beneficiaryUUId: uuid,
      purpose: purpose!,
      category: category?.uuid,
      note: note,
    );
    final Either<Failure, ReceiptModel> result = await _repo.create(
      inputs,
    );
    return result.fold((Failure failure) {
      emit(TransferCreatedState());
      emit(TransferErrorState(failure));
      MyToast(failure.message);
      return null;
    }, (ReceiptModel receipt) async {
      await sl<TransactionHistoryCubit>().getWallet();
      return receipt;
    });
  }

  void reset() {
    amountController.text = '';
    purpose = null;
    category = null;
  }

  @override
  Future<void> close() {
    amountController.dispose();
    return super.close();
  }
}
