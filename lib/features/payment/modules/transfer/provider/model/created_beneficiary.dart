import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';

class CreatedBeneficiaryModel extends ParentModel {
  String? message;
  Beneficiary? beneficiary;

  CreatedBeneficiaryModel({this.message, this.beneficiary});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return CreatedBeneficiaryModel(
        beneficiary: json['beneficiary'] != null
            ? Beneficiary()
                .fromJsonInstance(json['beneficiary'] as Map<String, dynamic>)
            : null,
        message: converter.convertToString(key: "message", defaultValue: ""));
  }
}
