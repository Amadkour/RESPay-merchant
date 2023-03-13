part of 'customer_loyalty_cubit.dart';

@immutable
abstract class CustomerLoyaltyState {}

class CustomerLoyaltyInitial extends CustomerLoyaltyState {}

class CustomerLoyaltyLoading extends CustomerLoyaltyState {}

class CustomerLoyaltyLoaded extends CustomerLoyaltyState {}

class CustomerLoyaltyChangeRate extends CustomerLoyaltyState {}

class CustomerLoyaltyError extends CustomerLoyaltyState {
  final Failure failure;

  CustomerLoyaltyError(this.failure);
}

/// i made this to avoid in case something went wrong in
/// showing no effect the customer loyalty home screen
///
class ShowCustomerLoyaltyLoading extends CustomerLoyaltyState {}

class RedeemCustomerLoyaltyLoading extends CustomerLoyaltyState {}

class CustomerLoyaltyRedeemed extends CustomerLoyaltyState {}

class CustomerLoyaltyRedeemError extends CustomerLoyaltyState {
  final Failure failure;

  CustomerLoyaltyRedeemError(this.failure);
}
