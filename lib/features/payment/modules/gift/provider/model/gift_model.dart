import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class GiftModel extends ParentModel{
  String ?giftId;
  String ?sender;
  double ?price;
  GiftModel({this.giftId, this.sender, this.price});

  @override
  GiftModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter =FromMap(map: json);
    return GiftModel(
      giftId:converter.convertToString(key: "giftId",defaultValue: ""),
      sender:converter.convertToString(key: "sender",defaultValue: ""),
      price:converter.convertToDouble(key: "price",defaultValue: 0.0),
    );
  }

}
