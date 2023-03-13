part of 'promotions_cubit.dart';

@immutable
abstract class PromotionsState {}

class PromotionsInitial extends PromotionsState {}
class ResetSearchbar extends PromotionsState {}
class PromotionsLoading extends PromotionsState {}
class PromotionsLoaded extends PromotionsState {}
class PromotionsError extends PromotionsState {}
