part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class PasswordTransparentChanged extends RegisterState {}

class ConfirmPasswordTransparentChanged extends RegisterState {}

class RegisterErrorState extends RegisterState {
  final Failure failure;

  RegisterErrorState(this.failure);
}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {}

class BirthDateChanged extends RegisterState {
  final String text;

  BirthDateChanged(this.text);
}
