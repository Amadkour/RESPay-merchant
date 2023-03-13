import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/country_type.dart';

class CountryTypeRepository {
  CountryTypeRepository._singleTone();

  static final CountryTypeRepository _instance =
      CountryTypeRepository._singleTone();

  static CountryTypeRepository get instance => _instance;

  Future<List<CountryType>> getCountryListRepository() async {
    final String string =
        await rootBundle.loadString('assets/jsons/countries.json');
    final Map<String, dynamic>? map =
        await json.decode(string) as Map<String, dynamic>?;
    return (map!['countries'] as List<dynamic>)
        .map((dynamic e) => CountryType.fromApiJson(e as Map<String, dynamic>))
        .toList();
  }
}
