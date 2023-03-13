import 'package:equatable/equatable.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';

class TransferCategoryModel extends Equatable{
  final int? id;
  final String? uuid;
  final String? slug;
  final String? name;
  final String? icon;

  const TransferCategoryModel({this.id, this.uuid, this.slug, this.name, this.icon});

  TransferCategoryModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter =FromMap(map: json);
    return TransferCategoryModel(
      id:converter.convertToInt(key: "id",defaultValue: -1),
      uuid:converter.convertToString(key: "uuid",defaultValue: ""),
      slug:converter.convertToString(key: "slug",defaultValue: ""),
      name:converter.convertToString(key: "name",defaultValue: ""),
      icon:converter.convertToString(key: "icon",defaultValue: ""),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => <Object?>[id,slug,uuid,name,icon];
}
