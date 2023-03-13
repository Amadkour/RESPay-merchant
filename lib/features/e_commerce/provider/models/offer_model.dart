import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class OfferModel extends ParentModel{
 int? id;
 String? title;
 String? imageUrl;
 String ?onOfferTap;

 OfferModel({this.id, this.title, this.imageUrl, this.onOfferTap});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return OfferModel(
     onOfferTap: converter.convertToString(key: "onOfferTap",defaultValue: ""),
     id: converter.convertToInt(key: "id",defaultValue: -1),
     title: converter.convertToString(key: "title",defaultValue: ""),
     imageUrl: converter.convertToString(key: "imageUrl",defaultValue: ""),
    );
  }
}
