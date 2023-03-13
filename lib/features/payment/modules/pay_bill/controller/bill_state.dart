part of 'bill_cubit.dart';

@immutable
abstract class BillState {}

class BillInitial extends BillState {}

class BillChangeType extends BillState {}

class BillTypesLoading extends BillState {}

class BillRequestLoading extends BillState {}

class BillTypesLoaded extends BillState {}

class BillRequestLoaded extends BillState {}

class PayBillLoading extends BillState {}

class PayBillErrorState extends BillState {
  final Failure failure;

  PayBillErrorState(this.failure);
}

class PayBillLoaded extends BillState {}

class BillDataChanged extends BillState {}
