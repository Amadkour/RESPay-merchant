import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class FavouriteProductAddedModel extends ParentModel{
  String? message;
  int? favoritesCount;

  FavouriteProductAddedModel({this.message, this.favoritesCount});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter =FromMap();
    return FavouriteProductAddedModel(
      message: converter.convertToString(key: "message"),
      favoritesCount: converter.convertToInt(key: "favorites_count")
    );
  }
}
