import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/controller/cart_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/view/componantes/discount_code_text_field.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/view/componantes/list_of_items_in_cart.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/view/componantes/summary_bottom_sheet_body.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/badge/favourite_badge.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

class CardItemsPage extends StatelessWidget {
  const CardItemsPage({super.key, required this.shopUUID});

  final String shopUUID;
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
        appBarWidget: MainAppBar(
            title: "my_cart",
            actions: FavoriteBadge(
              shopUUID: shopUUID,
            )),
        bottomNavigationBar: BlocProvider<CartCubit>.value(
          value: sl<CartCubit>(),
          child: BlocBuilder<CartCubit, CartState>(
            builder: (BuildContext context, CartState state) {
              if(state is CartLoading){
                return const NativeLoading();
              }
              return context
                      .read<CartCubit>()
                      .cartModel!
                      .cart!
                      .items!
                      .isNotEmpty
                  ? SummaryBody(
                      onTapButton: () {
                        CustomNavigator.instance.pushNamed(RoutesName.checkout);
                      },
                    )
                  : const SizedBox.shrink();
            },
          ),
        ),
        scaffold: BlocProvider<CartCubit>.value(
          value: sl<CartCubit>(),
          child: BlocBuilder<CartCubit, CartState>(
            buildWhen: (CartState previous, CartState current) =>
                current is! CartCubitShowSummary &&
                current is! UpdateCartInLoading &&
                current is! CartUpdated,
            builder: (BuildContext context, CartState state) {
              if(state is CartLoading){
                return const NativeLoading();
              }
              if (state is ItemAdditionInLoading) {
                return const NativeLoading();
              }
              return InkWell(
                overlayColor: MaterialStateProperty.all(AppColors.lightWhite),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                onDoubleTap: () {
                  sl<CartCubit>().setShowSummaryValue();
                },
                child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: const EdgeInsets.all(20),
                    color: AppColors.lightWhite,
                    child: BlocProvider<CartCubit>.value(
                      value: sl<CartCubit>(),
                      child: Builder(builder: (BuildContext context) {
                        if (sl<CartCubit>().cartModel!.cart!.items!.isEmpty) {
                          return Center(
                            child: SingleChildScrollView(
                              child: EmptyWidget(
                                  message: tr("no_items_in_cart"),
                                  height: context.width * 0.5,
                                  width: context.width * 0.5),
                            ),
                          );
                        }
                        return SingleChildScrollView(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              tr("list_item"),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blackColor),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const ListOfItemsInCart(),
                            const SizedBox(
                              height: 25,
                            ),
                            Text(
                              tr("use_promotion"),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.blackColor),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const DiscountCodeTextField(
                              shopUUID: "",
                            )
                          ],
                        ));
                      }),
                    )),
              );
            },
          ),
        ));
  }
}
