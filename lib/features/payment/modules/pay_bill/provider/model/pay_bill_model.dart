import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class PayBillModel extends ParentModel{
  PayBillModel({
      this.message,});

  // PayBillModel.fromJson(dynamic json) {
  //   message = json['message'];
  // }
  String? message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);

    return PayBillModel(

    message: converter.convertToString(key: 'message')
    );
  }

}
