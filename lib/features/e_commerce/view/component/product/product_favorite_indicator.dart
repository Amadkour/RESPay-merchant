import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';

import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/controller/favourite_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';

class ProductFavoriteIndicator extends StatelessWidget {
  const ProductFavoriteIndicator({
    super.key,
    required this.itemKey,
    required this.product,
  });
  final String itemKey;
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteCubit>.value(
        value: sl<FavoriteCubit>(),
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
          buildWhen: (FavoriteState previous, FavoriteState current) =>
              sl<FavoriteCubit>().buildWhenCondition(product),
          builder: (BuildContext context, FavoriteState state) {
            if (state is FavoriteCubitItemUpdateStateLoading) {
              return const SizedBox.square(
                  dimension: 20,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ));
            }
            return InkWell(
              key: Key(itemKey),
              onTap: () {
                if (sl<FavoriteCubit>().currentProduct == "") {
                  sl<FavoriteCubit>().setCurrentProduct(product.id!);
                  if (sl<FavoriteCubit>().isInFav(product)) {
                    sl<FavoriteCubit>().removeFromFavorite(product.id!);
                  } else {
                    sl<FavoriteCubit>().addToFavorite(product);
                  }
                }
              },
              child: MyImage.svgAssets(
                url: sl<FavoriteCubit>().isInFav(product)
                    ? "assets/icons/e_commerce/infav.svg"
                    : "assets/icons/e_commerce/favourite.svg",
                width: 19,
                height: 19,
                color: sl<FavoriteCubit>().isInFav(product)
                    ? Colors.red
                    : AppColors.blackColor,
              ),
            );
          },
        ));
  }
}
