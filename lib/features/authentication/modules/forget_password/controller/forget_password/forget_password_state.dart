part of 'forget_password_cubit.dart';

@immutable
abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordExpand extends ForgetPasswordState {}

class ForgetPasswordError extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordFinishLoading extends ForgetPasswordState {}
class ForgetPasswordUpdateScreen extends ForgetPasswordState {}

class ForgetPasswordFailure extends ForgetPasswordState {}
