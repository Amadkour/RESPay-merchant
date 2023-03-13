part of 'res_dialog_cubit.dart';

@immutable
abstract class ResDialogState {}

class ResDialogInitial extends ResDialogState {}

class ResDialogChangeTabIndex extends ResDialogState {}

class ResDialogChangeSecure extends ResDialogState {}

class ResDialogLoading extends ResDialogState {}

class ResDialogLoadingFinished extends ResDialogState {}
