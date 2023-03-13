import 'package:flutter/cupertino.dart';
import 'package:res_pay_merchant/core/res/extensions/strings_extension.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/constants.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/controller/beneficiary_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/view/entry/transfer/child/transfer_types/mobile_wallet/mobile_wallet_international_transfer.dart';
import 'package:res_pay_merchant/features/payment/modules/beneficiary/view/entry/transfer/child/transfer_types/mobile_wallet/mobile_wallet_local_transfer.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/busienss/trasnfer_method_types.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/summary/beneficairy_summary/international_summary/mobile_wallet_international_summary.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/summary/beneficairy_summary/local_summary/mobile_wallet_local_summary.dart';

class TransferMobileWalletMethodType extends TransferMethodType {
  TransferMobileWalletMethodType(super.methodTypeName, super.numberOfTab);

  @override
  Widget buildWidgetForTap1() {
    return const MobileWalletInternationalTransfer();
  }

  @override
  Widget buildWidgetForTap2() {
    return const MobileWalletLocalTransfer();
  }

  @override
  Widget buildWidgetSummary1() {
    return const MobileWalletInternationalSummary();
  }

  @override
  Widget buildWidgetSummary2() {
    return const MobileWalletLocalSummary();
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
      walletName: sl<BeneficiaryCubit>().currentWalletName,
      type: "external",
      methodType: methodTypeName,
      method: ServiceType.transfer,
    );
  }
}
