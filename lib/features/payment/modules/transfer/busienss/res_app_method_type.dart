import 'package:flutter/cupertino.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/view/entry/transfer/child/transfer_types/res_app_type/res_app_international_transfer.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/view/entry/transfer/child/transfer_types/res_app_type/res_app_local_transfer.dart.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/busienss/trasnfer_method_types.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/summary/beneficairy_summary/international_summary/res_app_international_summary.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/summary/beneficairy_summary/local_summary/res_app_local_summary.dart';

class TransferResAppMethodType extends TransferMethodType {
  TransferResAppMethodType(super.methodTypeName,super.numberOfTab);

  @override
  Widget buildWidgetForTap1() {
    return const ResAppInternationalTransfer();
  }

  @override
  Widget buildWidgetForTap2() {
    return const ResAppLocalTransfer();
  }

  @override
  Widget buildWidgetSummary1() {
    return const ResAppInternationalSummary();
  }

  @override
  Widget buildWidgetSummary2() {
    return const ResAppLocalSummary();
  }

  @override
  Beneficiary fillInternationalData() {
    return Beneficiary(
      firstName: sl<BeneficiaryCubit>().firstName,
      lastName: sl<BeneficiaryCubit>().lastName,
      phoneNumber: sl<BeneficiaryCubit>().phoneNumber,
      relation: sl<BeneficiaryCubit>().currentRelationShip,
      countryId: sl<BeneficiaryCubit>().currentCountry!.id,
      currencyId: sl<BeneficiaryCubit>().currentCurrency!.id,
      type: "external",
      methodType: methodTypeName,
    );
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
