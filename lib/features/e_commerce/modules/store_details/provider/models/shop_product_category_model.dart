import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class ShopProductCategoryModel extends ParentModel{
  int? id;
  String? uuid;
  String? name;

  ShopProductCategoryModel({this.id, this.uuid, this.name});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return ShopProductCategoryModel(
        id : converter.convertToInt(key: 'id'),
        uuid : converter.convertToString(key: 'uuid'),
        name : converter.convertToString(key: 'name')
    );
  }
}
