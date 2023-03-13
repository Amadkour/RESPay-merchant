part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}
class CartLoading extends CartState {}
class ItemAdditionInLoading extends CartState {}
class CartLoaded extends CartState {}
class CartError extends CartState {}
class AddToCart extends CartState {}
class RemoveFromCart extends CartState {}
class IncreaseItemCount extends CartState {}
class DecreaseItemCount extends CartState {}
class TotalCalculated extends CartState {}
class CartDeleteAddress extends CartState {}
class CartAddAddress extends CartState {}
class ConvertBetweenRemoveAndCheck extends CartState {}
class CartCubitShowSummary extends CartState {}
class CartPromotionsLoading extends CartState {}
class CartUpdated extends CartState {}
class UpdateCartInLoading extends CartState {}
