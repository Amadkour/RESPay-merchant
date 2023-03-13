import 'package:res_pay_merchant/core/public_module/provider/model/country.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class CountryListModel extends ParentModel {
  final List<Country> countries;

  CountryListModel({this.countries = const <Country>[]});
  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final List<Map<String, dynamic>> countries =
        List<Map<String, dynamic>>.from(json['countries'] as List<dynamic>);

    return CountryListModel(
        countries: List<Country>.from(
            countries.map((Map<String, dynamic> e) => Country.fromMap(e))));
  }
}
