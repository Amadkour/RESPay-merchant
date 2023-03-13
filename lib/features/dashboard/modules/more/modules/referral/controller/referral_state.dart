part of 'referral_cubit.dart';

@immutable
abstract class ReferralState {}

class ReferralInitial extends ReferralState {}

class ReferralLoading extends ReferralState {}

class ReferralLoaded extends ReferralState {}

class ReferralError extends ReferralState {}
