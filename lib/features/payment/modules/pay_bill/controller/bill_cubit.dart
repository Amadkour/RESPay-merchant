import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/provider/model/bill_summary.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/provider/repo/bill_repo.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

part 'bill_state.dart';

class BillCubit extends Cubit<BillState> {
  BillCubit(BillRepo billRepo) : super(BillTypesLoading()) {
    onInt(billRepo);
  }

  Map<String, dynamic> billTypes = <String, String>{};
  String? billTypeModel;
  late BillSummaryModel billSummary;

  bool get buttonEnabled => customerId.length == 19;

  Future<void> onInt(BillRepo billRepo) async {
    emit(BillTypesLoading());

    (await billRepo.getSupplies()).fold(
        (Failure l) => MyToast(l.errors.toString()), (Map<String, dynamic> r) => billTypes = r);
    billTypeModel = billTypes.values.first.toString();
    emit(BillTypesLoaded());
  }

  String customerId = '';

  void changeBank(String? value) {
    billTypeModel = value;
    emit(BillDataChanged());
  }

  void onCustomerIdChanged(String id) {
    customerId = id;

    emit(BillTypesLoaded());
  }

  /// ----this function call pay bill method
  /// if isCheck =false it means i want to pay bill
  /// else means i need to get bill summary
  Future<bool> getBill() async {
    emit(PayBillLoading());
    final String typeKey = billTypes.entries
        .firstWhere((MapEntry<String, dynamic> element) => element.value == billTypeModel)
        .key;
    return (await sl<BillRepo>().payBill(
      customerId: customerId,
      supplierType: typeKey,
      isCheck: true,
    ))
        .fold((Failure l) {
      emit(PayBillErrorState(l));

      return false;
    }, (ParentModel? r) {
      emit(PayBillLoaded());
      if (r != null) {
        billSummary = r as BillSummaryModel;

        return true;
      }
      emit(PayBillLoaded());
      return false;
    });
  }

  Future<ReceiptModel?> payBill() async {
    emit(PayBillLoading());
    final String typeKey = billTypes.entries
        .firstWhere((MapEntry<String, dynamic> element) => element.value == billTypeModel)
        .key;
    return await (await sl<BillRepo>().payBill(
      customerId: customerId,
      supplierType: typeKey,
    ))
        .fold((Failure l) {
      emit(PayBillErrorState(l));
      return null;
    }, (ParentModel? r) {
      emit(PayBillLoaded());
      return ReceiptModel(
        id: '1234',
        date: DateTime.now(),
        amount: billSummary.bill?.total?.totalBill ?? "",
        type: 'pay_bill',
      );
    });
  }
}
