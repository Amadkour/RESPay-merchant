import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';

RegExp numberRegExp = RegExp(r"\D");

extension Cleaining on TextEditingController {
  String get removeNonNumber => text.replaceAll(numberRegExp, "");
}

// rename it to size extension because it make conflict wit ui size class

extension SizeExtension on BuildContext {
  double get height => MediaQuery.of(globalKey.currentContext!).size.height;

  double get bottomPadding =>
      MediaQuery.of(globalKey.currentContext!).padding.bottom;

  double get width => MediaQuery.of(globalKey.currentContext!).size.width;

  ThemeData get theme => Theme.of(globalKey.currentContext!);

  bool get isTablet => MediaQuery.of(this).size.shortestSide > 600;
}

extension DateTimeConstrain on DateTime {
  ///return true if user age < 18 years
  bool isUnderAge() => DateTime.now().difference(this).inDays < 6574;
}

extension ListExtensions<T> on Iterable<T> {
  T? whereOrNull(bool Function(T) test) {
    for (final T element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }
}

extension OnTap on InkWell {
  void onTap() {}
}
