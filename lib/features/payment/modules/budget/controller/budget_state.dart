// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'budget_cubit.dart';

abstract class BudgetState {
  const BudgetState();
}

class BudgetInitial extends BudgetState {}

class BudgetLoading extends BudgetState {}

class BudgetChangeDuration extends BudgetState {
  final String duration;

  const BudgetChangeDuration(this.duration);
}

class BudgetSelectCategory extends BudgetState {
  final CategoryTypeModel category;

  const BudgetSelectCategory(this.category);
}

class BudgetError extends BudgetState {
  final Failure failure;

  const BudgetError(this.failure);
}

class BudgetCategoriesLoaded extends BudgetState {}

class BudgetCategoryAdded extends BudgetState {}

class BudgetCategoryNameChanged extends BudgetState {
  final String name;

  const BudgetCategoryNameChanged(this.name);
}

class BudgetCategoryDeleted extends BudgetState {
  final String uuid;

  const BudgetCategoryDeleted(this.uuid);
}

class BudgetAmountChanged extends BudgetState {}

class BudgetCategoryToggle extends BudgetState {
  final bool value;

  const BudgetCategoryToggle({required this.value});
}

class BudgetCategoryLoading extends BudgetState {
  final String uuid;
  const BudgetCategoryLoading({
    required this.uuid,
  });
}
