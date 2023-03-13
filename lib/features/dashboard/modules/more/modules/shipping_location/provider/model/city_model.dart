import 'package:equatable/equatable.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class CityModel extends Equatable with ParentModel {
  final String? uuid;
  final String? name;
  final bool? isActive;

  CityModel({this.uuid, this.name, this.isActive});

  @override
  CityModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return CityModel(
      uuid: converter.convertToString(key: "uuid", defaultValue: ""),
      name: converter.convertToString(key: "name", defaultValue: ""),
      isActive: converter.convertToBool(key: "is_active", defaultValue: false),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['name'] = name;
    data['is_active'] = isActive;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => <Object?>[uuid, name, isActive];
}
