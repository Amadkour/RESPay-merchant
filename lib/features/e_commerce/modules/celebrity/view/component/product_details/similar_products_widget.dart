import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/product_details/product_similar_item_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';

class SimilarProductsWidget extends StatelessWidget {
  const SimilarProductsWidget({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 8),
          child: Text(
            tr('other_products'),
            style: paragraphStyle,
          ),
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.similarProduct
                .slices(context.isTablet ? 3 : 2)
                .map((List<ProductModel> list) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: list
                      .map(
                        (ProductModel product) => SimilarProductWidget(
                          product: product,
                        ),
                      )
                      .toList(),
                ),
              );
            }).toList()),
      ],
    );
  }
}
