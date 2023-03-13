import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';

class CountryType {
  CountryType(
      {int? countryTypeId,
      String? countryTypeCode,
      String? countryTypeTitle,
        String? countryPhoneCode,

      String? countryTypeIcon}) {
    id = countryTypeId;
    code = countryTypeCode;
    title = countryTypeTitle;
    phoneCode =countryPhoneCode;
    icon = countryTypeIcon;
  }

  CountryType.fromApiJson(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    id = converter.convertToInt(key: 'id');
    code = converter.convertToString(key: 'code');
    title = converter.convertToString(key: 'name');
    phoneCode = converter.convertToString(key: 'phone_code');
    icon = converter.convertToString(key: 'flag');
  }

  late int? id;
  late String? code;
  late String? title;
  late String? phoneCode;
  late String? icon;
}
