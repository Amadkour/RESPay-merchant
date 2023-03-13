part of 'pin_code_cubit.dart';

@immutable
abstract class PinCodeState {}

class PinCodeInitial extends PinCodeState {}
class PinCodeChanged extends PinCodeState {
  final String code;

  PinCodeChanged(this.code);

}

class PinCodeLoading extends PinCodeState {}

class PinCodeOnDoneLoading extends PinCodeState {}

class PinCodeOnDoneWithBiometricsLoading extends PinCodeState {}

class PinCodeChangeSwitcher extends PinCodeState {
  final bool enable;

  PinCodeChangeSwitcher({required this.enable});
}

class PinCodeLoaded extends PinCodeState {}

class PinCodeFailure extends PinCodeState {}

class BioMetricLoading extends PinCodeState {
  final int index;

  BioMetricLoading(this.index);
}

class BiometricChanged extends PinCodeState {
  final bool value;

  BiometricChanged({required this.value});
}

class BiometricError extends PinCodeState {
  final Failure failure;

  BiometricError(this.failure);
}

class PinCodeError extends PinCodeState {
  final Failure failure;

  PinCodeError(this.failure);
}
