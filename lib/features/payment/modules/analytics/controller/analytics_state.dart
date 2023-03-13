part of 'analytics_cubit.dart';

abstract class AnalyticsState {
  const AnalyticsState();
}

class AnalyticsInitial extends AnalyticsState {}

class AnalyticsLoading extends AnalyticsState {}

class AnalyticsLoaded extends AnalyticsState {}

class CategoryColorChanged extends AnalyticsState {
  final Color color;

  CategoryColorChanged(this.color);
}

class CategoryIconChanged extends AnalyticsState {
  final String icon;

  CategoryIconChanged(this.icon);
}

class AnalyticsDurationChanged extends AnalyticsState {
  final String duration;

  AnalyticsDurationChanged(this.duration);
}

class AnalyticsCategoryLoading extends AnalyticsState {}

class AnalyticsCategoryUpdated extends AnalyticsState {
  final AnalyticsCategory category;

  AnalyticsCategoryUpdated(this.category);
}

class AnalyticsCategoryDeleted extends AnalyticsState {
  final AnalyticsCategory category;

  AnalyticsCategoryDeleted(this.category);
}

class CategoryNameChanged extends AnalyticsState {
  final String name;

  CategoryNameChanged(this.name);
}

class AnalyticsFailure extends AnalyticsState {
  final Failure failure;

  const AnalyticsFailure(this.failure);
}

class AnalyticsTransactionSearch extends AnalyticsState {
  final String query;

  AnalyticsTransactionSearch(this.query);
}
