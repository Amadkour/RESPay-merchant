part of 'create_new_password_cubit.dart';

@immutable
abstract class CreateNewPasswordState {}

class CreateNewPasswordInitial extends CreateNewPasswordState {}

class CreateNewPasswordChangeSecureState extends CreateNewPasswordState {}
class CreateNewPasswordUpdateScreen extends CreateNewPasswordState {}

class CreateNewPasswordLoadingState extends CreateNewPasswordState {}

class CreateNewPasswordLoadingFinishedState extends CreateNewPasswordState {}


class CreateNewPasswordFailure extends CreateNewPasswordState {}
