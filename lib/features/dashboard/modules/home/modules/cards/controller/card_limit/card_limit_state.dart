part of 'card_limit_cubit.dart';

@immutable
abstract class CardLimitState {}

class CardLimitInitial extends CardLimitState {}

class CardLimitChangeSliderValue extends CardLimitState {}
class CardLimitChangeValues extends CardLimitState {}
