part of 'privacy_cubit.dart';

@immutable
abstract class PrivacyState {}

class PrivacyInitial extends PrivacyState {}

class PrivacyLoaded extends PrivacyState {}
class PrivacyLoading extends PrivacyState {}

class PrivacyChangeExpanded extends PrivacyState {}
class PrivacyChangeFailure extends PrivacyState {}
