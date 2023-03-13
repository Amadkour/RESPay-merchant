part of 'profile_cubit.dart';

@immutable
abstract class ProfileState{}

class ProfileInitial extends ProfileState {}

class IsSaveStateChanged extends ProfileState {}

class ProfileUpdateBirthDateSate extends ProfileState {}

class IsReadOnlyStateChanged extends ProfileState {}

class GoToEditMode extends ProfileState {}

class ProfileUpdated extends ProfileState {}

class ProfileCubitShowProfileLoading extends ProfileState {}

class ImageChanged extends ProfileState {}

class RequiredProfileFieldsExist extends ProfileState {}

class ResetFormState extends ProfileState {}

class PhoneNumberChanged extends ProfileState {}

class PhoneNumberUpdated extends ProfileState {}

class ProfileLoaded extends ProfileState {}

class ProfileInitError extends ProfileState {}

class ProfileUpdateLoading extends ProfileState {}

class ProfileUpdateLoaded extends ProfileState {}

class ProfileTextFieldsChanged extends ProfileState {}

class FieldsErrorErased extends ProfileState {}

/// API FAILURES STATES
class ShowProfileErrorState extends ProfileState {}

class UpdateProfileErrorState extends ProfileState {}
