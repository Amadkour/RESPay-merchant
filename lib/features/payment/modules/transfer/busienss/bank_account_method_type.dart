import 'package:flutter/cupertino.dart';
import 'package:res_pay_merchant/core/res/extensions/strings_extension.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/controller/bank_name_controller/bank_name_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/view/entry/transfer/child/transfer_types/bank_account_type/bank_account_international_transfer.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/view/entry/transfer/child/transfer_types/bank_account_type/bank_account_local_transfer.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/busienss/trasnfer_method_types.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/summary/beneficairy_summary/international_summary/bank_account_international_summary.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/summary/beneficairy_summary/local_summary/bank_account_local_summary.dart';

class TransferBankAccountMethodType extends TransferMethodType {
  TransferBankAccountMethodType(super.methodTypeName, super.numberOfTab);

  @override
  Widget buildWidgetForTap1() {
    return const BankAccountInternationalTransfer();
  }

  @override
  Widget buildWidgetForTap2() {
    return const BankAccountLocalTransfer();
  }

  @override
  Widget buildWidgetSummary1() {
    return const BankAccountInternationalSummary();
  }

  @override
  Widget buildWidgetSummary2() {
    return const BankAccountLocalSummary();
  }

  @override
  Beneficiary fillInternationalData() {
    return Beneficiary(
      firstName: sl<BeneficiaryCubit>().firstName,
      lastName: sl<BeneficiaryCubit>().lastName,
      accountNumber: (sl<BeneficiaryCubit>().accountNumber).removeNonNumber,
      swiftCode: sl<BeneficiaryCubit>().swiftCode,
      iban: sl<BeneficiaryCubit>().iban,
      relation: sl<BeneficiaryCubit>().currentRelationShip,
      countryId: sl<BeneficiaryCubit>().currentCountry!.id,
      currencyId: sl<BeneficiaryCubit>().currentCurrency!.id,
      nationalityId: sl<BeneficiaryCubit>().currentNationality!.id,
      bankName: sl<BankNameCubit>().currentBankName!.name,
      type: "external",
      methodType: methodTypeName,
    );
  }

  @override
  Beneficiary fillLocalData() {
    return Beneficiary(
      firstName: sl<BeneficiaryCubit>().firstName,
      lastName: sl<BeneficiaryCubit>().lastName,
      accountNumber: (sl<BeneficiaryCubit>().accountNumber).removeNonNumber,
      iban: sl<BeneficiaryCubit>().iban,
      bankName: sl<BankNameCubit>().currentBankName!.name,
      type: "internal",
      methodType: methodTypeName,
    );
  }
}
