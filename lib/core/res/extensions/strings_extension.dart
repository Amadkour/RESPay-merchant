import 'dart:ui';

import 'package:res_pay_merchant/core/res/utils/extenstions.dart';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

extension CustomString on String? {
  int? parseToInt() {
    return int.tryParse(this?.toString().replaceAll(',', '') ?? '');
  }

  double? parseToDouble() {
    return double.tryParse(this?.toString().replaceAll(',', '') ?? '');
  }

  Color toColor() {
    final StringBuffer buffer = StringBuffer();
    if (this?.length == 6 || this?.length == 7) buffer.write('ff');
    buffer.write(this?.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String get removeNonNumber {
    return toString().replaceAll(numberRegExp, "");
  }

  String capitalize() {
    return (this?[0].toUpperCase() ?? "") + (this?.substring(1) ?? "");
  }
}
