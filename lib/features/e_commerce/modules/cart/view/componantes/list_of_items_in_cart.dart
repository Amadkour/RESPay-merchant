import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/controller/cart_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/view/componantes/product_cart_item.dart';

class ListOfItemsInCart extends StatelessWidget {
  const ListOfItemsInCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartCubit>.value(
      value: sl<CartCubit>(),
      child: BlocBuilder<CartCubit,CartState>(
        buildWhen: (CartState previous, CartState current) => current is! CartCubitShowSummary&&current is! UpdateCartInLoading &&current is! CartInitial ,
        builder: (BuildContext context, CartState state) => ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return ProductCartItem(
                productIndex: index,
                productModel: sl<CartCubit>().cartModel!.cart!.items![index],);
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 12,
              );
            },
            itemCount: sl<CartCubit>().cartModel!.cart!.items!.length),
      )
    );
  }
}
