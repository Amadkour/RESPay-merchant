import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';

import 'package:res_pay_merchant/core/widget/dialogs/confitm_cancel_dialog.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/controller/cart_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/cart_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/view/componantes/item_counter.dart';

import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

class ProductCartItem extends StatelessWidget {
  const ProductCartItem(
      {super.key, required this.productModel, required this.productIndex});
  final CartItemModel productModel;
  final int productIndex;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartCubit>.value(
        value: sl<CartCubit>(),
        child: BlocBuilder<CartCubit, CartState>(
          buildWhen: (CartState previous, CartState current) =>
              sl<CartCubit>().currentProduct == productModel.uuid &&
              current is! CartUpdated,
          builder: (BuildContext context, CartState state) => Container(
              height: 90,
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Row(
                children: <Widget>[
                  MyImage.network(
                    width: 90,
                    url: productModel.thumbImage,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "${productModel.price} ${tr("SAR")}",
                              style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                          BlocBuilder<CartCubit, CartState>(
                            buildWhen:
                                (CartState previous, CartState current) =>
                                    sl<CartCubit>().conditionToRebuild(
                                        productModel.productUuid!),
                            builder: (BuildContext context, CartState state) {
                              return InkWell(
                                key: Key(
                                    "cart_item_at_index_${productIndex}_delete_button"),
                                onTap: () {
                                  ConfirmCancelDialog(
                                      context: context,
                                      // size: Size(context.width*0.7, context.height*0.5),
                                      title: tr(
                                          "are_you_sure_you_want_delete_product"),
                                      onConfirm: () async {
                                        sl<CartCubit>().setCurrentProduct(
                                            productModel.productUuid!);
                                        sl<CartCubit>()
                                            .removeFromCart(productModel.uuid!);
                                      });
                                },
                                child: MyImage.svgAssets(
                                  width: 14,
                                  height: 14,
                                  url: "assets/icons/e_commerce/editicon.svg",
                                ),
                              );
                            },
                          )
                        ],
                      )),
                      Expanded(
                          child: Text(
                        productModel.title!,
                        style: const TextStyle(
                            color: Color(0xff5A6367),
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      )),
                      Expanded(
                          child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              productModel.title!,
                              style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12),
                            ),
                          ),
                          ItemCounter(
                            productIndex: productIndex,
                            productModel: productModel,
                          )
                        ],
                      )),
                    ],
                  ))
                ],
              )),
        ));
  }
}
