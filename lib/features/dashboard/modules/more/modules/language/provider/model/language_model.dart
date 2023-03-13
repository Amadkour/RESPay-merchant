import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';

class LanguageModel {
  String? name;
  String? locale;
  String? icon;

  LanguageModel({this.name, this.locale, this.icon});

  @override
  LanguageModel.fromJson(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    name = converter.convertToString(key: 'name');
    locale = converter.convertToString(key: 'locale');
    icon = converter.convertToString(key: 'icon');
  }
}
