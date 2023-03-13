import 'package:flutter/material.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/product/product_item_in_colum_view.dart';

class ProductSamples extends StatelessWidget {
  const ProductSamples({
    super.key,
    required this.productsList,
    required this.shopUUID
  });

  final List<ProductModel>? productsList;
  final String shopUUID;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        itemCount: productsList!.take(2).length,
        itemBuilder: (BuildContext context, int index) {
          return ProductItemInColum(productModel:productsList!.take(2).toList()[index],
            shopUUID: shopUUID,
            favouriteIconKey: "favourite_item_at_index_$index",cartIconKey: "product_item_at_index_$index",);
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          //childAspectRatio: 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: 230,
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }
}
