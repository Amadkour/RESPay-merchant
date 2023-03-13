part of 'login_cubit.dart';

@immutable
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => <Object>[];
}

class LoginControllerInitial extends LoginState {}

///----------------------------- Login Screen States --------------------///
class LoginControllerChangeTabIndexState extends LoginState {
  final int index;

  const LoginControllerChangeTabIndexState({required this.index,});

  @override
  List<Object> get props => <Object>[index];
}


class LoginControllerChangeLanguageDropDownState extends LoginState {

  final String value;

  const LoginControllerChangeLanguageDropDownState({required this.value});

  @override
  List<Object> get props => <Object>[value];

}

class LoginControllerEmitState extends LoginState {
  final bool enable;

  const LoginControllerEmitState({required this.enable});

  @override
  List<Object> get props => <Object>[enable];

}

class LoginControllerChangePasswordSecureTextState
    extends LoginState {

  final bool enable;

  const LoginControllerChangePasswordSecureTextState({required this.enable});

  @override
  List<Object> get props => <Object>[enable];

}
class LoginControllerChanged
    extends LoginState {}

class LoginControllerIsLoginLoading extends LoginState {}

class LoginControllerIsLoginFinishLoading extends LoginState {}

class LoginControllerFailure extends LoginState {}

///----------------------------- RES Login States --------------------///
class LoginControllerDialogChangePasswordSecureTextState
    extends LoginState {}

class LoginControllerDialogChangeTabIndexState extends LoginState {}
