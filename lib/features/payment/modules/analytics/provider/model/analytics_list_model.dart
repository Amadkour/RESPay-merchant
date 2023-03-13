// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/provider/model/analytics_category.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/transaction_model.dart';

class AnalyticsListModel extends ParentModel {
  final List<TransactionModel> transactions;
  final List<AnalyticsCategory> categories;
  final Map<String, dynamic> chart;
  double get total => categories.map((AnalyticsCategory e) => e.amount).fold(
      0,
      (double previousValue, double? element) =>
          previousValue + (element ?? 0));
  AnalyticsListModel({
    this.transactions = const <TransactionModel>[],
    this.categories = const <AnalyticsCategory>[],
    this.chart = const <String, dynamic>{},
  });
  @override
  ParentModel fromJsonInstance(Map<String, dynamic> json) {
    final Map<String, dynamic> charts = json['chart'] is List
        ? <String, dynamic>{}
        : json['chart'] as Map<String, dynamic>;
    final List<TransactionModel> transactions = List<TransactionModel>.from(
        (json['transactions'] as List<dynamic>).map((dynamic e) =>
            TransactionModel.fromJson(e as Map<String, dynamic>)));
    final List<AnalyticsCategory> categories = List<AnalyticsCategory>.from(
        (json['categories'] as List<dynamic>).map((dynamic e) =>
            AnalyticsCategory.fromJson(e as Map<String, dynamic>)));
    return AnalyticsListModel(
      transactions: transactions,
      categories: categories,
      chart: charts,
    );
  }
}
