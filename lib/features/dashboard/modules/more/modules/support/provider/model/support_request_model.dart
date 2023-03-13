import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class SupportResponseModel extends ParentModel{
  String? message;

  SupportResponseModel({this.message});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter =FromMap(map: json);

    return SupportResponseModel(
      message: converter.convertToString(key: "message")
    );
  }
}
