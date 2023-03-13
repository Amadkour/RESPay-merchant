part of 'terms_cubit.dart';

@immutable
abstract class TermsState extends Equatable{
  @override
  List<Object> get props => <Object>[];

}

class TermsInitial extends TermsState {}
class TermsLoaded extends TermsState {}
class TermsLoading extends TermsState {}
class TermsChangeExpanded extends TermsState {
  final bool isExpanded;
  TermsChangeExpanded({required this.isExpanded});
  @override
  List<Object> get props => <Object>[isExpanded];


}
class TermsCubitFailure extends TermsState {}
