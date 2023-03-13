part of 'shop_cubit.dart';

@immutable
abstract class ShopState {
  const ShopState();
}

class ShopInitial extends ShopState {}

class ResetSearchbar extends ShopState {}

class ShopLoading extends ShopState {}

class ShopLoaded extends ShopState {}
class ImageChangeUpdated extends ShopState {}

class ShopFailure extends ShopState {
  final String error;

  const ShopFailure(this.error);
}

class CategoryFilterChanged extends ShopState {
  final int categoryIndex;

  const CategoryFilterChanged(this.categoryIndex);
}
