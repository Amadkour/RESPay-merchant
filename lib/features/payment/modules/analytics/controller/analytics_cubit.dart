import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/provider/model/analytics_category.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/provider/model/analytics_list_model.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/provider/repo/analytics_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/transaction_model.dart';

part 'analytics_state.dart';

class AnalyticsCubit extends Cubit<AnalyticsState> {
  AnalyticsCubit(this._repo, {bool isAuthorized = true}) : super(AnalyticsInitial()) {
    if (!isAuthorized) {
      model = AnalyticsListModel(
          transactions: <TransactionModel>[],
          categories: <AnalyticsCategory>[
            const AnalyticsCategory(uuid: 'uuid', icon: 'logo', amount: 0, name: 'supermarket')
          ]);
    } else {
      load();
    }
  }

  List<AnalyticsCategory> get categories => model?.categories ?? <AnalyticsCategory>[];
  List<TransactionModel> transactions = <TransactionModel>[];
  final AnalyticsRepo _repo;

  AnalyticsListModel? model;
  Color? color;
  String? icon;
  String? name;
  String duration = "monthly";

  void setColor(Color color) {
    this.color = color;
    emit(CategoryColorChanged(color));
  }

  void setIcon(String icon) {
    this.icon = icon;
    emit(CategoryIconChanged(icon));
  }

  void setName(String name) {
    this.name = name;
    emit(CategoryNameChanged(name));
  }

  Future<void> load() async {
    emit(AnalyticsLoading());
    final Either<Failure, ParentModel> result = await _repo.getCategories();
    result.fold((Failure l) {
      emit(AnalyticsFailure(l));
      MyToast(l.message);
    }, (ParentModel r) {
      model = r as AnalyticsListModel;
      transactions = model?.transactions ?? <TransactionModel>[];
      emit(AnalyticsLoaded());
    });
  }

  void changeDuration(String duration) {
    this.duration = duration;
    emit(AnalyticsDurationChanged(duration));
  }

  void initCategoryForEdit(int index) {
    final AnalyticsCategory category = categories[index];
    color = category.color;
    name = category.name;
    icon = category.icon;
  }

  Future<void> addCategory() async {
    try{
      emit(AnalyticsCategoryLoading());
      await Future<void>.delayed(const Duration(seconds: 1));
      print('categories = $categories');
      final AnalyticsCategory category = AnalyticsCategory(
        uuid: "",
        icon: icon,
        color: color,
        amount: 0,
        name: name,
      );
      categories.add(category);
      resetData();
      emit(AnalyticsCategoryUpdated(category));

    }catch(e){
      emit(AnalyticsFailure(ServerFailure()));
    }
  }

  void transactionSearch(String query) {
    if (query.isEmpty) {
      transactions = model?.transactions ?? <TransactionModel>[];
    } else {
      transactions = model?.transactions
          .where((TransactionModel element) =>
      element.operationName.toLowerCase().startsWith(query.toLowerCase()) ||
          element.reference.startsWith(query))
          .toList() ??
          <TransactionModel>[];
    }
    emit(AnalyticsTransactionSearch(query));
  }

  void deleteCategory(int index) {
    final AnalyticsCategory category = categories[index];
    categories.remove(category);
    emit(AnalyticsCategoryDeleted(category));
  }

  void editCategory(int index) {
    final AnalyticsCategory category = categories[index];
    categories[index] = category.copyWith(
      name: name,
      icon: icon,
      color: color,
    );
    emit(AnalyticsCategoryUpdated(category));
  }

  void resetData() {
    icon = null;
    color = null;
    name = null;
  }
}
