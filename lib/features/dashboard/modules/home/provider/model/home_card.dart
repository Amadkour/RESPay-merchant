import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';

class HomeCard {
  HomeCard({
    String? cardNumber,
    String? icon,
    String? name,
    String? uuid,
  }) {
    _cardNumber = cardNumber;
    _icon = icon;
    _name = name;
    _uuid = uuid;
  }

  HomeCard.fromJson(Map<String, dynamic> json) {
    final FromMap converter = FromMap(map: json);
    _cardNumber = converter.convertToString(key: 'card_number');
    _icon = converter.convertToString(key: 'icon');
    _name = converter.convertToString(key: 'name');
    _uuid = converter.convertToString(key: 'uuid');
  }
  String? _cardNumber;
  String? _icon;
  String? _name;
  String? _uuid;

  String? get cardNumber => _cardNumber;
  String? get icon => _icon;
  String? get name => _name;
  String? get uuid => _uuid;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['card_number'] = _cardNumber;
    map['icon'] = _icon;

    return map;
  }
}
