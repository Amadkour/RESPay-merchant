part of 'support_cubit.dart';

@immutable
abstract class SupportState{
}

class SupportInitial extends SupportState {}

class TextFieldResetState extends SupportState {}

class SupportRequiredFieldFound extends SupportState {}
class SupportSendingIssue extends SupportState {}
class SupportSentIssueDone extends SupportState {}
class SupportTextFieldChanged extends SupportState {}
class SupportDataIsVerificationSuccess extends SupportState {}
class FieldsIsClear extends SupportState {}
class SupportLoadingState extends SupportState {}

/// API FAILURES STATES
class SupportErrorState extends SupportState {}
