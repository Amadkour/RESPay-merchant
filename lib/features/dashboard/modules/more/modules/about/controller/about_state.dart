part of 'about_cubit.dart';

@immutable
abstract class AboutState {}

class AboutInitial extends AboutState {}

class AboutFailure extends AboutState {}

class AboutLoading extends AboutState {}

class AboutLoaded extends AboutState {}
