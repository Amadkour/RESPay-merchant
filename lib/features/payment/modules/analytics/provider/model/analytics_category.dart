import 'dart:ui';

import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';

class AnalyticsCategory {
  final String uuid;

  final String? icon;
  final Color? color;
  final double? amount;
  final String? name;
  const AnalyticsCategory({
    required this.uuid,
    required this.icon,
    this.color,
    required this.amount,
    required this.name,
  });

  factory AnalyticsCategory.fromJson(Map<String, dynamic> map) {
    final FromMap converter = FromMap(map: map);
    return AnalyticsCategory(
      uuid: converter.convertToString(key: 'uuid')!,
      icon: converter.convertToString(key: 'icon'),
      // color: converter.convertToString(key: 'color').toColor(),
      amount: converter.convertToDouble(key: 'total_spent', defaultValue: 0),
      name: converter.convertToString(key: 'title'),
    );
  }

  AnalyticsCategory copyWith({
    String? id,
    String? icon,
    Color? color,
    double? amount,
    String? name,
  }) {
    return AnalyticsCategory(
      uuid: id ?? uuid,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      amount: amount ?? this.amount,
      name: name ?? this.name,
    );
  }
}
