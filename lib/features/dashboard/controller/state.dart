import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => <Object>[];

}

class Empty extends DashboardState {}

class DashboardLoading extends DashboardState {}

class Loaded extends DashboardState {}

class IndexChanged extends DashboardState {
  final int index;

  const IndexChanged(this.index);

  @override
  List<Object> get props => <Object>[index];
}

class LanguageLoaded extends DashboardState {}
