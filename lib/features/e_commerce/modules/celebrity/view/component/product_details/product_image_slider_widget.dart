import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:res_pay_merchant/core/res/utils/extenstions.dart';

import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/product_controller/product_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';

import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/res_app_image.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

import 'package:res_pay_merchant/core/res/theme/colors.dart';

class ProductImagesSliderWidget extends StatelessWidget {
  const ProductImagesSliderWidget({
    super.key,
    required this.productController,
    required this.product,
  });

  final ProductCubit productController;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (BuildContext context, ProductState state) => SizedBox(
        width: context.width,
        height: context.height * 0.4,
        child: Stack(
          children: <Widget>[
            product.images.isNotEmpty
                ? PageView.builder(
                    onPageChanged: productController.setCurrentImageIndex,
                    itemCount: product.images.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String image = product.images.elementAt(index);
                      return Center(
                        child: MyImage.network(
                          url: image,
                          width: context.width,
                          height: null,
                          fit: BoxFit.fitWidth,
                        ),
                      );
                    },
                  )
                : Stack(children: <Widget>[
                    ResAppImage(
                      borderRadius: 0,
                      width: context.width,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: context.theme.primaryColor.withAlpha(150),
                      ),
                      // alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          tr('There is no images to review'),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ]),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (BuildContext context, ProductState state) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      List<Widget>.generate(product.images.length, (int index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width:
                          productController.productImageIndex == index ? 20 : 7,
                      height: 7,
                      margin: const EdgeInsetsDirectional.only(end: 4),
                      decoration: BoxDecoration(
                        color: productController.productImageIndex == index
                            ? AppColors.navy
                            : AppColors.greyColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
