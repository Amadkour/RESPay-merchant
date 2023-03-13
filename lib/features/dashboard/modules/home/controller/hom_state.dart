part of 'hom_cubit.dart';

@immutable
abstract class HomeState {}

class HomInitial extends HomeState {}

class HomeRefreshDataSate extends HomeState {}

class HomeLoaded extends HomeState {}

class HomeWalletError extends HomeState {}

class HomeLoading extends HomeState {}

class HomeFailure extends HomeState {}

class HomeToggleCard extends HomeState {}

class HomeUpdateScreen extends HomeState {}
