import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/provider/model/bank_name.dart';

class BankNamesModel extends ParentModel {
  List<BankName>? banks;

  BankNamesModel({this.banks});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return BankNamesModel(
        banks: converter.convertToListOFModel(
            jsonData: json['banks'], modelInstance: BankName()));
  }
}
