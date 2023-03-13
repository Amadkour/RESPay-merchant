import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_cubit_state.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  SearchCubit() : super(SearchCubitInitial());

  void onTextChanged(String value) {
    emit(OnSearchQueryChanged(value));
  }
}
