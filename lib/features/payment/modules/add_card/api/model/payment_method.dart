import 'package:res_pay_merchant/core/res/utils/parse_model/from_map.dart';

class PaymentMethod {
  final String uuid;
  final String? name;
  final String? icon;
  final String? slug;
  final bool? isActive;
  final bool? isDefault;
  PaymentMethod(
      {required this.uuid,
      required this.name,
      required this.icon,
      required this.isActive,
      required this.isDefault,
      required this.slug});

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    final FromMap converter = FromMap(map: map);
    return PaymentMethod(
      uuid: converter.convertToString(key: 'uuid')!,
      name: converter.convertToString(key: 'name'),
      icon: converter.convertToString(key: 'icon'),
      isActive: converter.convertToBool(key: 'isActive'),
      isDefault: converter.convertToBool(key: 'isDefault'),
      slug: converter.convertToString(key: 'slug'),
    );
  }
}
