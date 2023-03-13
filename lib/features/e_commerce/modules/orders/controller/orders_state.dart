part of 'orders_cubit.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => <Object?>[];
}

class OrdersInitial extends OrdersState {}

class OrdersCubitResetSearchbar extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {}

class OrdersSearched extends OrdersState with EquatableMixin {
  final String query;

  const OrdersSearched(this.query);
  @override
  List<Object?> get props => <Object?>[query];
}

class OrdersFailure extends OrdersState {
  final Failure failure;

  const OrdersFailure(this.failure);
}

class OrderFilterStatusChanged extends OrdersState with EquatableMixin {
  final String? status;

  const OrderFilterStatusChanged(this.status);
  @override
  List<Object?> get props => <Object?>[status];
}

class SingleOrderLoading extends OrdersState {}

class SingleOrderFailure extends OrdersState {
  final Failure failure;

  const SingleOrderFailure(this.failure);
}

class OrderBoughtAgainError extends OrdersFailure {
  const OrderBoughtAgainError(super.failure);
}

class OrderBoughtAgainLoading extends OrdersState {}

class OrderTracked extends OrdersState {}

class OrderBoughtAgainLoaded extends OrdersState {}

class OrderComplainImagePicked extends OrdersState with EquatableMixin {
  final String path;
  final int index;

  const OrderComplainImagePicked(this.path, this.index);

  @override
  List<Object?> get props => <Object?>[path, index];
}

class OrderCanceled extends OrdersState {}

class OrderComplained extends OrdersState {}
