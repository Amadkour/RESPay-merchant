import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class UserModel extends ParentModel{
  int? id;
  String? name;
  double? earnedMoney;

  UserModel({this.id, this.name, this.earnedMoney});


  @override
  UserModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter =FromMap(map: json);

    return UserModel(
      id:converter.convertToInt(key: "id",defaultValue: -1),
      name:converter.convertToString(key: "name",defaultValue: ""),
      earnedMoney:converter.convertToDouble(key: "earnedMoney",defaultValue: 0.0),
    );
  }
}
