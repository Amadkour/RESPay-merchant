part of 'store_detail_cubit.dart';

@immutable
abstract class StoreDetailState {}

class StoreDetailInitial extends StoreDetailState {}
class ShopLoaded extends StoreDetailState {}
class ShopLoading extends StoreDetailState {}
class ProductsFilterChanged extends StoreDetailState {}
class SingleShopFailure extends StoreDetailState {
  final String error;
  SingleShopFailure(this.error);
}
class HotOffersLoaded extends StoreDetailState {}
class ProductsFiltered extends StoreDetailState {}
class SingleShopLoaded extends StoreDetailState {
  final Shops shops;
  SingleShopLoaded(this.shops);
}
