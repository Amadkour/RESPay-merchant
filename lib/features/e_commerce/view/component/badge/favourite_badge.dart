import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';

import 'package:res_pay_merchant/features/e_commerce/modules/favourite/controller/favourite_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/badge/badge_widget_icon.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class FavoriteBadge extends StatefulWidget {
  const FavoriteBadge({super.key, required this.shopUUID});
  final String shopUUID;

  @override
  State<FavoriteBadge> createState() => _FavoriteBadgeState();
}

class _FavoriteBadgeState extends State<FavoriteBadge> {
  @override
  void initState() {
    super.initState();
    sl<FavoriteCubit>().getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FavoriteCubit>.value(
      value: sl<FavoriteCubit>(),
      child: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (BuildContext context, FavoriteState state) {
        return InkWell(
            key: favoriteIconInAppBarKey,
            onTap: () {
              if (context.read<FavoriteCubit>().favoritesModel != null &&
                  state is! FavoritesLoading) {
                CustomNavigator.instance.pushReplacementNamed(
                    RoutesName.favorite,
                    argument: widget.shopUUID);
              }
            },
            child: BadgeWidgetIcon(
              icon: "assets/icons/e_commerce/favourite.svg",
              number: context.watch<FavoriteCubit>().favoritesModel == null
                  ? 0
                  : context
                      .watch<FavoriteCubit>()
                      .favoritesModel!
                      .favorites!
                      .items!
                      .length,
            ));
      }),
    );
  }
}
