import 'package:res_pay_merchant/core/public_module/provider/model/currency.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

class CurrencyListModel extends ParentModel {
  final List<Currency> currencies;

  CurrencyListModel({this.currencies = const <Currency>[]});
  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final List<Map<String, dynamic>> currencyList =
        List<Map<String, dynamic>>.from(json['currencies'] as List<dynamic>);

    return CurrencyListModel(
        currencies: List<Currency>.from(
            currencyList.map((Map<String, dynamic> e) => Currency.fromMap(e))));
  }
}
