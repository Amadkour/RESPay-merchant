// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/category_type.dart';

class BudgetCategoryModel extends Equatable {
  final String uuid;
  final String name;
  final String slug;
  final double amount;
  final double used;
  final double remain;
  final double percentage;
  final bool? isActive;
  final String icon;

  const BudgetCategoryModel({
    required this.uuid,
    required this.name,
    required this.amount,
    required this.used,
    required this.remain,
    required this.percentage,
    required this.icon,
    required this.slug,
    this.isActive,
  });

  factory BudgetCategoryModel.fromMap(Map<String, dynamic> map) {

    return BudgetCategoryModel(
      uuid: map['uuid'] as String,
      name: map['name'] as String,
      icon: map['icon'] as String,
      amount: ((map['amount'] ?? 0) as num).toDouble(),
      used: ((map['spent'] ?? 0) as num).toDouble(),
      remain: ((map['remaining'] ?? 0) as num).toDouble(),
      percentage: ((map['remaining'] ?? 0) as num).toDouble(),
      isActive: map['is_active'] as bool?,
      slug: map['slug'] as String? ?? "",
    );
  }

  @override
  List<Object?> get props => <Object?>[
        uuid,
        name,
        icon,
        amount,
        used,
        remain,
        percentage,
        isActive,
        slug,
      ];

  BudgetCategoryModel copyWith({
    String? uuid,
    String? nameAr,
    String? nameEn,
    CategoryTypeModel? type,
    double? budget,
    double? used,
    double? remain,
    double? percentage,
    bool? isActive,
    String? icon,
    String? slug,
  }) {
    return BudgetCategoryModel(
      uuid: uuid ?? this.uuid,
      name: nameAr ?? name,
      icon: icon ?? this.icon,
      amount: budget ?? amount,
      used: used ?? this.used,
      remain: remain ?? this.remain,
      percentage: percentage ?? this.percentage,
      isActive: isActive ?? this.isActive,
      slug: slug ?? this.slug,
    );
  }
}
