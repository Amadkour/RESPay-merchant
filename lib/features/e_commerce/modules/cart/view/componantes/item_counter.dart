import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';

import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/controller/cart_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/cart_model.dart';

import 'package:res_pay_merchant/core/res/theme/colors.dart';

class ItemCounter extends StatelessWidget {
  final CartItemModel productModel;
  final int productIndex;
  const ItemCounter(
      {super.key, required this.productModel, required this.productIndex});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartCubit>.value(
      value: sl<CartCubit>(),
      child: BlocBuilder<CartCubit, CartState>(
        buildWhen: (CartState previous, CartState current) =>
            sl<CartCubit>().conditionToRebuild(productModel.uuid!),
        builder: (BuildContext context, CartState state) {
          return Row(
            children: <Widget>[
              InkWell(
                onDoubleTap: () {
                  sl<CartCubit>().setCurrentProduct(productModel.uuid!);
                  sl<CartCubit>().decreaseItemCount(
                      itemUUID: productModel.uuid!,
                      quantity: int.parse(productModel.quantity!) - 1);
                },
                key: Key("cart_item_at_index_${productIndex}_minus_button"),
                onTap: () {
                  sl<CartCubit>().setCurrentProduct(productModel.uuid!);
                  sl<CartCubit>().decreaseItemCount(
                      itemUUID: productModel.uuid!,
                      quantity: int.parse(productModel.quantity!) - 1);
                },
                child: MyImage.svgAssets(
                  width: 23,
                  height: 23,
                  url: "assets/icons/e_commerce/minus.svg",
                ),
              ),
              const SizedBox(
                width: 3,
              ),
              Container(
                  constraints: const BoxConstraints(minWidth: 17),
                  height: 17,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.blackColor,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(3))),
                  alignment: Alignment.center,
                  child: Text(
                    productModel.quantity.toString(),
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blackColor),
                  )),
              const SizedBox(
                width: 3,
              ),
              InkWell(
                onDoubleTap: () {
                  sl<CartCubit>().setCurrentProduct(productModel.uuid!);
                  sl<CartCubit>().increaseItemCount(
                      itemUUID: productModel.uuid!,
                      quantity: int.parse(productModel.quantity!) + 1);
                },
                key: Key("cart_item_at_index_${productIndex}_add_button"),
                onTap: () {
                  sl<CartCubit>().setCurrentProduct(productModel.uuid!);
                  sl<CartCubit>().increaseItemCount(
                      itemUUID: productModel.uuid!,
                      quantity: int.parse(productModel.quantity!) + 1);
                },
                child: MyImage.svgAssets(
                  width: 23,
                  height: 23,
                  url: "assets/icons/e_commerce/plus.svg",
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
