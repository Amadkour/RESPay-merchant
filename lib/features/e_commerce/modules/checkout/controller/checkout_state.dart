part of 'checkout_cubit.dart';

@immutable
abstract class CheckoutState {}

class CheckoutInitial extends CheckoutState {}
class CheckoutFailure extends CheckoutState {}
class CheckoutPlaceOrderLoad extends CheckoutState {}
class CheckoutPlaceOrderLoaded extends CheckoutState {}
class CheckoutChangePaymentMethod extends CheckoutState {}
class CheckoutChangeToggleCards extends CheckoutState {}
class CheckoutLoading extends CheckoutState {}
