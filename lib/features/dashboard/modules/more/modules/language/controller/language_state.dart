part of 'language_cubit.dart';

@immutable
abstract class LanguageState {}

class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {}

class LanguageLoaded extends LanguageState {}

class LanguageChangeRadioValue extends LanguageState {}

class LanguageChangeLanguageLoading extends LanguageState {}

class LanguageChangeLanguageLoaded extends LanguageState {}

class LanguageFailure extends LanguageState {}
