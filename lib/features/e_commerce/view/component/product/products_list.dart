import 'package:flutter/material.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/product/product_item_in_colum_view.dart';

class ProductsList extends StatelessWidget {
  final List<ProductModel>products;
  final String shopUUID;
  final bool needToShowIsSoldOut;
  const ProductsList({
    required this.shopUUID,
  this.needToShowIsSoldOut=false,
    super.key,required this.products
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return ProductItemInColum(
          shopUUID: shopUUID,
          needToShowIsSoldOut: needToShowIsSoldOut,
          productModel: products[index],
          favouriteIconKey: "favourite_item_at_index_$index",
          cartIconKey: "product_item_at_index_$index",
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.74,
        crossAxisSpacing: 12,
        mainAxisSpacing: 10,
        mainAxisExtent: 230,
      ),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}
