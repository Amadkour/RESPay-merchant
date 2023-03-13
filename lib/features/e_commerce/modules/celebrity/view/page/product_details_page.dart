import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/e_commerce_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/controller/cart_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/product_controller/product_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/product_details/product_color_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/product_details/product_details_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/product_details/product_image_slider_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/product_details/product_size_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/product_details/similar_products_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/varient.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.product, required this.shopUUID});

  final ProductModel product;
  final String shopUUID;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarWidget: CelebrityAppbar(
          title: tr(
            'product_details',
          ),
          shopUUID: shopUUID),
      scaffold: BlocProvider<ProductCubit>(
        create: (BuildContext context) => ProductCubit(product),
        child: Builder(builder: (BuildContext context) {
          final ProductCubit productController = context.read<ProductCubit>();
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ProductImagesSliderWidget(
                  productController: productController,
                  product: product,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ProductDetailsWidget(product: product),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Divider(
                          thickness: 4,
                          color: AppColors.backgroundColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ///-----variants
                            ...List<Widget>.generate(product.variants.length,
                                (int index) {
                              final MapEntry<String, List<Variant>> entry =
                                  product.variants.entries.elementAt(index);
                              if (entry.key == "color") {
                                return ProductColorWidget(
                                    product: product,
                                    productController: productController);
                              } else {
                                return BlocBuilder<ProductCubit, ProductState>(
                                  builder: (BuildContext context,
                                          ProductState state) =>
                                      ProductSizeWidget(
                                    variantList: entry,
                                    onChanged: (Variant value) {
                                      productController.selectVariant(
                                          value, entry.key);

                                      log(productController.selectedVarients
                                          .toString());
                                    },
                                    selectedVarient: productController
                                        .selectedVarients[entry.key],
                                  ),
                                );
                              }
                            }),

                            ///description
                            if (product.description?.isNotEmpty ??
                                false) ...<Widget>[
                              Text(
                                tr('description'),
                                style: paragraphStyle,
                              ),
                              Html(data: product.description ?? """"""),
                            ],
                            if (product.similarProduct.isNotEmpty)
                              SimilarProductsWidget(product: product),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: product.quantity > 0
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        offset: Offset(0, 8),
                        blurRadius: 33,
                        color: Color.fromRGBO(38, 38, 38, 0.1),
                      )
                    ],
                  ),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 20, top: 24),
                  child: BlocProvider<CartCubit>.value(
                    value: sl<CartCubit>(),
                    child: BlocBuilder<CartCubit, CartState>(
                      builder: (BuildContext context, CartState state) {
                        if (state is ItemAdditionInLoading) {
                          return const SizedBox.square(
                              child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ));
                        }
                        return Row(
                          children: <Widget>[
                            Expanded(
                              child: LoadingButton(
                                onTap: () async {
                                  await sl<CartCubit>().addToCart(product.id!);
                                  CustomNavigator.instance.pushNamed(
                                      RoutesName.cart,
                                      arguments: shopUUID);
                                },
                                topPadding: 0,
                                isLoading: false,
                                title: tr('buy_now'),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: LoadingButton(
                                key: addToCartKey,
                                onTap: () {
                                  sl<CartCubit>().addToCart(product.id!);
                                },
                                topPadding: 0,
                                title: tr('add_to_cart'),
                                backgroundColor: Colors.white,
                                borderColor: AppColors.borderColor,
                                fontColor: context.theme.primaryColor,
                                isLoading: false,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}
