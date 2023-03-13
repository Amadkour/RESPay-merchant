import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/controller/favourite_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/view/component/favourite_product_item.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/badge/cart_badge.dart';

class FavouritePage extends StatelessWidget {
  final String shopUUID;
  const FavouritePage({super.key, required this.shopUUID});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarWidget: MainAppBar(
        title: "my_favorite",
        actions: CartBadge(shopUUID: shopUUID),
      ),
      scaffold: BlocProvider<FavoriteCubit>.value(
        value: sl<FavoriteCubit>(),
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (BuildContext context, FavoriteState state) {
            if (state is FavoritesLoading) {
              return const NativeLoading();
            }
            if (sl<FavoriteCubit>().favoritesModel!.favorites!.items!.isEmpty) {
              return Center(
                child: EmptyWidget(
                    message: tr("no_items_in_cart"),
                    height: context.width * 0.5,
                    width: context.width * 0.5),
              );
            }
            return Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(20),
              color: AppColors.lightWhite,
              child: SingleChildScrollView(
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
                    if (sl<FavoriteCubit>()
                        .favoritesModel!
                        .favorites!
                        .items!
                        .isNotEmpty)
                      ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            //return Container();
                            return FavoriteProductItem(
                              productModel: sl<FavoriteCubit>()
                                  .favoritesModel!
                                  .favorites!
                                  .items![index],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 12,
                            );
                          },
                          itemCount: sl<FavoriteCubit>()
                              .favoritesModel!
                              .favorites!
                              .items!
                              .length)
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
