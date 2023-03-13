part of 'faq_cubit.dart';

@immutable
abstract class FaqState {}

class FreqLoaded extends FaqState {}
class FreqInitial extends FaqState {}
class FreqLoading extends FaqState {}
class ResetSearchbar extends FaqState {}
class FAQFailureSate extends FaqState {
  final String error;

  FAQFailureSate(this.error);
}
