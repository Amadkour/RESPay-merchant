import 'package:flutter/cupertino.dart';
import 'package:res_pay_merchant/core/res/extensions/strings_extension.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/view/entry/transfer/child/transfer_types/wistern_union_type/western_union_international_transfer.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/busienss/trasnfer_method_types.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/summary/beneficairy_summary/international_summary/wstern_union_international_summary.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/summary/beneficairy_summary/local_summary/western_union_local_summary.dart';

class TransferWesternMethodType extends TransferMethodType {
  TransferWesternMethodType(super.methodTypeName, super.numberOfTabs);

  @override
  Widget buildWidgetForTap1() {
    return const WesternUnionInternationalTransfer();
  }

  @override
  Widget buildWidgetForTap2() {
    return const SizedBox();
  }

  @override
  Widget buildWidgetSummary1() {
    return const WesternUnionInternationalSummary();
  }

  @override
  Widget buildWidgetSummary2() {
    return const WesternUnionLocalSummary();
  }

  @override
  Beneficiary fillLocalData() {
    return Beneficiary();
  }

  @override
  Beneficiary fillInternationalData() {
    return Beneficiary(
      firstName: sl<BeneficiaryCubit>().firstName,
      lastName: sl<BeneficiaryCubit>().lastName,
      accountNumber: (sl<BeneficiaryCubit>().accountNumber).removeNonNumber,
      relation: sl<BeneficiaryCubit>().currentRelationShip,
      countryId: sl<BeneficiaryCubit>().currentCountry!.id,
      currencyId: sl<BeneficiaryCubit>().currentCurrency!.id,
      type: "external",
      methodType: methodTypeName,
    );
  }
}
