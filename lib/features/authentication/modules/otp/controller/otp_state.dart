// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'otp_cubit.dart';

@immutable
abstract class OtpState {}

class OtpInitial extends OtpState {}

class OtpStartTime extends OtpState {}

class OtpChangeText extends OtpState {}

class OtpLoading extends OtpState {}

class OtpLoaded extends OtpState {
  final String message;

  OtpLoaded(this.message);
}

class OtpError extends OtpState {
  final Failure failure;
  OtpError(this.failure);
}
