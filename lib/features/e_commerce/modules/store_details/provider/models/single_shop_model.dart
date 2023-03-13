import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/provider/module/shop_model.dart';


class SingleShopModel extends ParentModel {
  String? message;
  Shops? shop;
  SingleShopModel({this.message, this.shop});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return SingleShopModel(
        message: converter.convertToString(key: "message"),
        shop: Shops.fromJson(json['shop'] as Map<String,dynamic>)
    );
  }
}
