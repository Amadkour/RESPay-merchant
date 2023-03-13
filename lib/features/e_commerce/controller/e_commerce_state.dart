part of 'e_commerce_cubit.dart';

@immutable
abstract class ECommerceState {}

class ECommerceInitial extends ECommerceState {}
class ECommerceLoading extends ECommerceState {}
class ECommerceLoaded extends ECommerceState {}
class ECommerceError extends ECommerceState {}
class CategoryFilterChanged extends ECommerceState {}
class ProductsFilterChanged extends ECommerceState {}
