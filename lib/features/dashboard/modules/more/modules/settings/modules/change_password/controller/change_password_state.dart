part of 'change_password_cubit.dart';

@immutable
abstract class ChangePasswordState {}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordTogglePassword extends ChangePasswordState {}

class ChangePasswordFailure extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordLoaded extends ChangePasswordState {}
class ChangePasswordSubmitForm extends ChangePasswordState {}
class ChangePasswordUpdateScreen extends ChangePasswordState {}
