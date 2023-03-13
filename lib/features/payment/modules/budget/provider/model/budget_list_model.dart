// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/budget_category_model.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/category_type.dart';

class BudgetListModel extends ParentModel with EquatableMixin {
  final List<BudgetCategoryModel> categories;
  final List<CategoryTypeModel> categoryTypes;
  final Map<String, dynamic> analytics;

  double get total => categories
      .map((BudgetCategoryModel e) => e.used)
      .fold(0, (double previousValue, double element) => previousValue + element);
  BudgetListModel(
      {this.categories = const <BudgetCategoryModel>[],
      this.categoryTypes = const <CategoryTypeModel>[],
      this.analytics = const <String, dynamic>{}});

  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final List<BudgetCategoryModel> categories = List<BudgetCategoryModel>.from(
        (json['budgets'] as List<dynamic>).map((dynamic e) => BudgetCategoryModel.fromMap(e as Map<String, dynamic>)));
    final List<CategoryTypeModel> types = List<CategoryTypeModel>.from(
        (json['categories'] as List<dynamic>).map((dynamic e) => CategoryTypeModel.fromMap(e as Map<String, dynamic>)));

    final Map<String, dynamic> analytics =
        json['chart'] is List ? <String, dynamic>{} : json['chart'] as Map<String, dynamic>;
    return BudgetListModel(
      categories: categories,
      categoryTypes: types,
      analytics: analytics,
    );
  }

  @override
  List<Object?> get props => <Object?>[categories, categoryTypes, analytics];
}

