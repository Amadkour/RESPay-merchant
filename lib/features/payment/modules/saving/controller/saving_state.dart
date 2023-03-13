part of 'saving_cubit.dart';

@immutable
abstract class SavingState {}

class SavingInitial extends SavingState {}

class SavingRolesLoadedState extends SavingState {}

class SavingChangeSwitcherState extends SavingState {}

class SavingDeleteRoleLoadingState extends SavingState {}

class SavingLoadingState extends SavingState {}

class SavingLoadedState extends SavingState {}

class SavingDeleteRoleLoadedState extends SavingState {}

class SavingToggleRoleLoadingState extends SavingState {}

class SavingToggleRoleLoadedState extends SavingState {}

class SavingButtonLoadingState extends SavingState {}

class SavingButtonLoadedState extends SavingState {}

class SavingAddNewRoleLoading extends SavingState {}

class SavingAddNewRoleLoaded extends SavingState {}

class SavingUpdateRoleLoading extends SavingState {}

class SavingUpdateRoleLoaded extends SavingState {}

class SavingUpdateScreen extends SavingState {}

/// Failures
class SavingGetSavingModelFailure extends SavingState {}

class SavingDeleteSavingModelFailure extends SavingState {}

class SavingChangeSwitcherFailure extends SavingState {}

class SavingToggleRoleFailure extends SavingState {}

class SavingUpdateRoleFailure extends SavingState {}

class SavingAddMoneyFailure extends SavingState {}

class SavingWithdrawFailure extends SavingState {}

class SavingAddRoleFailure extends SavingState {}
