import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/controller/store_detail_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/badge/cart_badge.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/badge/favourite_badge.dart';
import 'package:res_pay_merchant/features/search/components/build_search_bar.dart';

class CelebrityAppbar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  String shopUUID;
  CelebrityAppbar({
    super.key,
    required this.shopUUID,
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: size,
        child: AppBar(
          titleSpacing: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              CustomNavigator.instance.pop();
            },
            child: Container(
                margin:  const EdgeInsets.all(18),
                child: isArabic
                    ? RotatedBox(quarterTurns: 2 ,child: SvgPicture.asset("assets/icons/back.svg"))
                    : SvgPicture.asset("assets/icons/back.svg")
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: <Widget>[
              Expanded(
                child: title != null
                    ? Text(
                        tr(title!),
                        style: TextStyle(
                          color: AppColors.darkGrayColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : SearchBar(
                        onClear: () {},
                        showClear: sl<StoreDetailCubit>()
                            .searchBarController
                            .text
                            .isEmpty,
                        hintText: "search_product",
                        onChanged: (String value) {
                          sl<StoreDetailCubit>().filterByName(value);
                        },
                        controller: sl<StoreDetailCubit>().searchBarController),
              ),
              const SizedBox(
                width: 14,
              ),
              FavoriteBadge(shopUUID: shopUUID),
              const SizedBox(
                width: 14,
              ),
              CartBadge(
                shopUUID: shopUUID,
              ),
            ],
          ),
        ));
  }

  static const Size size = Size.fromHeight(55);

  @override
  Size get preferredSize => size;
}
