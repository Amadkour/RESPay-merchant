import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class FavouriteProductRemovedModel extends ParentModel{
  String? message;

  FavouriteProductRemovedModel({this.message});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    return FavouriteProductRemovedModel(
        message: converter.convertToString(key: "message"),

    );
  }
}
