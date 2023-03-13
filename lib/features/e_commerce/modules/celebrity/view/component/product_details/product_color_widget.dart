import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/product_controller/product_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/varient.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/view/component/color_widget.dart';

class ProductColorWidget extends StatelessWidget {
  const ProductColorWidget({
    super.key,
    required this.product,
    required this.productController,
  });

  final ProductModel product;
  final ProductCubit productController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          tr('choose_color'),
          style: paragraphStyle,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 26),
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (BuildContext context, ProductState state) => ColorWidget(
              colors: product.variants['color']!
                  .map((Variant e) => e.value)
                  .toList(),
              selectedColor: productController.color?.value,
              onColorSelected: (String v) {
                productController.selectColor(v);
              },
            ),
          ),
        ),
      ],
    );
  }
}
