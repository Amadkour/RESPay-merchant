part of 'product_cubit.dart';

abstract class ProductState {
  const ProductState();
}

class ProductInitial extends ProductState {}

class ProductImageIndexChanged extends ProductState {
  final int index;

  const ProductImageIndexChanged(this.index);
}

class ProductSelectSize extends ProductState with EquatableMixin {
  final String size;

  const ProductSelectSize(this.size);

  @override
  List<Object?> get props => <Object?>[size];
}

class ProductSelectColor extends ProductState {
  final Variant color;

  const ProductSelectColor(this.color);
}
