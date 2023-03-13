part of 'schedual_cubit.dart';

@immutable
abstract class ScheduleState {}

class ScheduleLoading extends ScheduleState {
  final bool loadedDays;
  final bool loadedTimes;
  ScheduleLoading({required this.loadedDays,required this.loadedTimes});
}

class ScheduleFailure extends ScheduleState {
  final String error;

  ScheduleFailure(this.error);
}
class ScheduleLoadingStat extends ScheduleState {}
class ChooseTime extends ScheduleState {}
