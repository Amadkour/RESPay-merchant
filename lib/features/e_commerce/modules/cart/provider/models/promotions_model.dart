import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class PromotionsModel extends ParentModel{
  List<ParentModel>? promotions;

  PromotionsModel({this.promotions});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    return PromotionsModel(
      promotions: (json['promotions'] as List<dynamic>).map((dynamic e) => SinglePromotion().fromJsonInstance(e as Map<String,dynamic>)).toList()
    );
  }
}

class SinglePromotion extends ParentModel{
  String? shopSlug;
  String? shopName;
  String? shopIcon;
  String? value;
  String? validTo;
  String? code;
  bool? isActive;
  int? offerCount;

  SinglePromotion(
      {this.shopSlug,
        this.shopName,
        this.shopIcon,
        this.value,
        this.validTo,
        this.code,
        this.offerCount,
        this.isActive});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter =FromMap(map: json);
    return SinglePromotion(
      shopSlug: converter.convertToString(key: "shop_slug"),
      shopName: converter.convertToString(key: "shop_name"),
      shopIcon: converter.convertToString(key: "shop_icon"),
      value: converter.convertToString(key: "value"),
      validTo: converter.convertToString(key: "valid_to"),
      code: converter.convertToString(key: "code"),
      isActive: converter.convertToBool(key: "is_active"),
      offerCount: converter.convertToInt(key: "offer_count")
    );
  }
}
