import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class BankName extends ParentModel{
  int? id;
  String? uuid;
  String? name;
  int? countryId;
  bool? isActive;
  bool? isDefault;
  String? icon;

  BankName(
      {this.id,
        this.uuid,
        this.name,
        this.countryId,
        this.isActive,
        this.isDefault,
      this.icon
      });

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return BankName(
        id : converter.convertToInt(key: "id",defaultValue: -1),
        uuid : converter.convertToString(key: "uuid",defaultValue: ""),
        name : converter.convertToString(key: "name",defaultValue: ""),
        countryId :  converter.convertToInt(key: "country_id",defaultValue: -1),
        isActive : converter.convertToBool(key: "is_active",defaultValue: false),
        isDefault : converter.convertToBool(key: "isDefault",defaultValue: false),
        icon : converter.convertToString(key: "icon"),
    );
  }
}
