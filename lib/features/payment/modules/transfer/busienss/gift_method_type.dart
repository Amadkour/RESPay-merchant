import 'package:flutter/cupertino.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/view/entry/transfer/child/transfer_types/gift_transfer_type/gift_local_transfer.dart.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/busienss/trasnfer_method_types.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/summary/beneficairy_summary/local_summary/gift_local_summary.dart';

class TransferGiftMethodType extends TransferMethodType {
  TransferGiftMethodType(super.methodTypeName, super.numberOfTab);

  @override
  Widget buildWidgetForTap1() {
    return const SizedBox();
  }

  @override
  Widget buildWidgetForTap2() {
    return const GiftLocalTransfer();
  }

  @override
  Widget buildWidgetSummary1() {
    return const SizedBox();
  }

  @override
  Widget buildWidgetSummary2() {
    return const GiftLocalSummary();
  }

  @override
  Beneficiary fillInternationalData() {
    return Beneficiary();
  }

  @override
  Beneficiary fillLocalData() {
    return Beneficiary(
      firstName: sl<BeneficiaryCubit>().firstName,
      lastName: sl<BeneficiaryCubit>().lastName,
      phoneNumber: sl<BeneficiaryCubit>().phoneNumber,
      type: "internal",
      methodType: methodTypeName,
    );
  }
}
