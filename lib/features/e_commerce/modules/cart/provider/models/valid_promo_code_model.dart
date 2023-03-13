import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class ValidPromoCodeModel extends ParentModel{
  String? message;

  ValidPromoCodeModel({this.message});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter =FromMap(map: json);
    return ValidPromoCodeModel(
      message: converter.convertToString(key: "message")
    );
  }
}
