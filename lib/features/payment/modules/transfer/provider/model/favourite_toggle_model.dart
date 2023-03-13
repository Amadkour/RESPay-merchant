import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class FavouriteToggleModel extends ParentModel{
  String? message;

  FavouriteToggleModel({this.message});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final FromMap converter =FromMap();
    return FavouriteToggleModel(
      message: converter.convertToString(key: "message")
    );
  }
}
