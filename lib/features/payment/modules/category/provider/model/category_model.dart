import 'dart:ui';

import 'package:res_pay_merchant/core/res/extensions/strings_extension.dart';

class CategoryModel {
  final int id;
  final String name;
  final String icon;
  final Color color;
  const CategoryModel({
    required this.id,
    required this.name,
    required this.color,
    required this.icon,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as int,
      name: map['name'] as String,
      color: map['color'].toString().toColor(),
      icon: map['icon'].toString(),
    );
  }
}
