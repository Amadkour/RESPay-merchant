part of 'search_cubit_cubit.dart';

abstract class SearchCubitState extends Equatable {
  const SearchCubitState();

  @override
  List<Object> get props => <Object>[];
}

class SearchCubitInitial extends SearchCubitState {}

class OnSearchQueryChanged extends SearchCubitState {
  final String text;

  const OnSearchQueryChanged(this.text);

  @override
  List<Object> get props => <Object>[text];
}
