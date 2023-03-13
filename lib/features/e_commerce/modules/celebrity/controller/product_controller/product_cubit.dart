import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/varient.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this.product) : super(ProductInitial()) {
    if (product.variants['color']?.isNotEmpty == true) {
      color = product.variants['color']!.first;
    }
    if (product.variants['size']?.isNotEmpty == true) {
      selectedVarients['size'] = product.variants['size']!.first;
    }
  }

  int productImageIndex = 0;

  Variant? color;
  Map<String, Variant> selectedVarients = <String, Variant>{};
  final ProductModel product;
  void setCurrentImageIndex(int index) {
    productImageIndex = index;
    emit(ProductImageIndexChanged(index));
  }

  void selectVariant(Variant size, String name) {
    selectedVarients.update(
      name,
      (Variant value) => size,
      ifAbsent: () => size,
    );
    emit(ProductSelectSize(size.uuid));
  }

  void selectColor(String color) {
    this.color = product.variants['color']!.firstWhere((Variant element) => element.value == color);
    emit(ProductSelectColor(this.color!));
  }
}
