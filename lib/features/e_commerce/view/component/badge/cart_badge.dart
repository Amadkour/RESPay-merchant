import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';

import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/controller/cart_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/badge/badge_widget_icon.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class CartBadge extends StatefulWidget {
  final String shopUUID;
  const CartBadge({super.key, required this.shopUUID});

  @override
  State<CartBadge> createState() => _CartBadgeState();
}

class _CartBadgeState extends State<CartBadge> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sl<CartCubit>().getCartProducts(widget.shopUUID);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CartCubit>.value(
      value: sl<CartCubit>(),
      child: BlocBuilder<CartCubit, CartState>(
          builder: (BuildContext context, CartState state) {
        return Row(
          children: <Widget>[
            InkWell(
                key: cartIconInAppBarKey,
                onTap: () async {
                  if (context.read<CartCubit>().cartModel != null &&
                      state is! CartLoading) {
                    context.read<CartCubit>().resetPromoCode();
                    CustomNavigator.instance.pushReplacementNamed(
                        RoutesName.cart,
                        argument: widget.shopUUID);
                  }
                },
                child: BadgeWidgetIcon(
                  icon: "assets/icons/e_commerce/cart.svg",
                  number: context.watch<CartCubit>().cartModel == null
                      ? 0
                      : context
                          .watch<CartCubit>()
                          .cartModel!
                          .cart!
                          .items!
                          .length,
                )),
            const SizedBox(
              width: 15,
            ),
          ],
        );
      }),
    );
  }
}
