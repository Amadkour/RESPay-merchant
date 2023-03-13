// ignore_for_file: parameter_assignments

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/budget_category_model.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/budget_list_model.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/category_type.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/create_budget_category_input.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/repo/budget_repo.dart';

part 'budget_state.dart';

class BudgetCubit extends Cubit<BudgetState> {
  BudgetCubit({BudgetRepo? repo}) : super(BudgetInitial()) {
    _repo = repo ?? sl<BudgetRepo>();

    amountController.addListener(() {
      input.budget = amountController.removeNonNumber;

      emit(BudgetAmountChanged());
    });
  }
  late BudgetRepo _repo;
  BudgetListModel model = BudgetListModel();

  CreateBudgetCategoryInput input = CreateBudgetCategoryInput();

  String duration = "monthly";
  CategoryTypeModel? category;

  final TextEditingController amountController = TextEditingController();

  ///This getter is responsible to enable or disable creation button
  ///according to user entered data
  bool get enableButton {
    return amountController.text.isNotEmpty && input.parentCategoryUuid != null;
  }

  /// This Function responsible to load
  /// user budgets categories and charts
  //!tested
  Future<bool> loadBudget() async {
    emit(BudgetLoading());

    final Either<Failure, ParentModel> result =
        await _repo.get(period: duration);
    return result.fold((Failure l) {
      emit(BudgetError(l));
      return false;
    }, (ParentModel r) {
      model = r as BudgetListModel;
      emit(BudgetCategoriesLoaded());
      return true;
    });
  }

  /// This Function responsible set  budget filter duration
  void changeDuration(String? duration) {
    this.duration = duration!;
    loadBudget();
  }

  /// This Function responsible set budget duration
  void changeCategory(CategoryTypeModel category) {
    input.parentCategoryUuid = category.uuid;

    this.category = category;
    emit(BudgetSelectCategory(category));
  }

  //! tested
  Future<bool> addCategory() async {
    emit(BudgetLoading());
    final Either<Failure, BudgetCategoryModel> result =
        await _repo.create(input);
    return result.fold((Failure l) {
      emit(BudgetError(l));
      return false;
    }, (BudgetCategoryModel r) async {
      await loadBudget();
      emit(BudgetCategoryAdded());
      return true;
    });
  }

  void initCategoryForEdit(BudgetCategoryModel category) {
    amountController.text = category.amount.toString();
    this.category = model.categoryTypes.firstWhere(
        (CategoryTypeModel element) =>
            element.name.toLowerCase() == (category.name.toLowerCase()));
    input = CreateBudgetCategoryInput(
      budget: category.amount.toString(),
      parentCategoryUuid: this.category?.uuid,
      uuid: category.uuid,
    );
  }

  //! tested
  Future<bool> updateCategory() async {
    emit(BudgetLoading());
    final Either<Failure, BudgetCategoryModel> result =
        await _repo.update(input);
    return result.fold((Failure l) {
      emit(BudgetError(l));
      return false;
    }, (BudgetCategoryModel r) async {
      await loadBudget();
      emit(BudgetCategoryAdded());
      return true;
    });
  }

  //! tested
  Future<bool> delete(String uuid) async {
    emit(BudgetLoading());
    final int index = model.categories
        .indexWhere((BudgetCategoryModel element) => uuid == element.uuid);
    if (index != -1) {
      final BudgetCategoryModel category = model.categories[index];
      final Option<Failure> result = await _repo.delete(category.uuid);
      return result.fold(() {
        loadBudget();
        return true;
      }, (Failure a) {
        emit(BudgetError(a));
        return false;
      });
    }
    else{
      return false;
    }
  }

  void removeCategory(int index) {
    final String uuid = model.categories[index].uuid;
    model.categories.removeAt(index);
    emit(BudgetCategoryDeleted(uuid));
  }

  //! tested

  Future<void> toggleCategory(String uuid) async {
    final int index = model.categories
        .indexWhere((BudgetCategoryModel element) => element.uuid == uuid);

    if (index != -1) {
      emit(BudgetCategoryLoading(uuid: uuid));

      final Option<Failure> result = await _repo.toggleCategory(uuid);
      return result.fold(() {
        model.categories[index] = model.categories[index].copyWith(
          isActive: !model.categories[index].isActive!,
        );

        emit(BudgetCategoryToggle(
          value: model.categories[index].isActive!,
        ));
      }, (Failure a) {
        emit(BudgetError(a));
      });
    }
  }

  void resetData() {
    input = CreateBudgetCategoryInput();
    amountController.text = '';
    category = null;
  }
}
