part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}
class NotificationReadLoading extends NotificationState {}

class NotificationFinishLoading extends NotificationState {}

class NotificationDelete extends NotificationState {}
class NotificationFailure extends NotificationState {}
