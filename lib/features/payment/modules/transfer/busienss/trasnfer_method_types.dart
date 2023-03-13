import 'package:flutter/cupertino.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';

abstract class TransferMethodType {
  TransferMethodType(this.methodTypeName, this.numberOfTabs);
  late String methodTypeName;
  int numberOfTabs = 2;

  Beneficiary fillInternationalData();
  Beneficiary fillLocalData();
  Widget buildWidgetForTap1();
  Widget buildWidgetForTap2();
  Widget buildWidgetSummary1();
  Widget buildWidgetSummary2();
}
