import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';

import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/appbar/e_commerce_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/dialogs/guest_dialog.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';
import 'package:res_pay_merchant/features/e_commerce/controller/e_commerce_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/controller/store_detail_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/view/component/hot_deals.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/view/component/product_samples.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/store_details/view/component/store_item_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/filter/list_of_product_filters.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/filter/product_filter_item.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/product/products_list.dart';

class StoreDetail extends StatefulWidget {
  final String shopSlug;

  const StoreDetail({super.key, required this.shopSlug});

  @override
  State<StoreDetail> createState() => _StoreDetailState();
}

class _StoreDetailState extends State<StoreDetail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sl<StoreDetailCubit>()
      ..resetSearchBar()
      ..getSingleShop(slug: widget.shopSlug);
  }

  @override
  Widget build(BuildContext context) {
    final Widget body = MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<ECommerceCubit>.value(
            value: sl<ECommerceCubit>()..resetFilterValues()),
        BlocProvider<StoreDetailCubit>.value(value: sl<StoreDetailCubit>()),
      ],
      child: BlocBuilder<ECommerceCubit, ECommerceState>(
        builder: (BuildContext context, ECommerceState state) {
          return BlocBuilder<StoreDetailCubit, StoreDetailState>(
            builder: (BuildContext context, StoreDetailState state) {
              if (state is ShopLoading || state is StoreDetailInitial) {
                return SizedBox(
                  width: context.width,
                  height: context.height,
                  child: NativeLoading(
                    size: context.width * 0.2,
                  ),
                );
              }
              if (state is SingleShopFailure) {
                return SingleChildScrollView(
                  child: EmptyWidget(
                    message: tr("this_shop_is_not_available_now"),
                    width: context.width * 0.5,
                    height: context.width * 0.5,
                  ),
                );
              }
              final List<ProductModel> filtered = sl<StoreDetailCubit>()
                  .getCorrectList(sl<ECommerceCubit>().currentFilterItem);
              return ColoredBox(
                color: AppColors.lightWhite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/shopimage.jpg",
                          fit: BoxFit.fitWidth,
                        )),
                    StoreItemWidget(shops: sl<StoreDetailCubit>().shop!),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        tr("list_of_products"),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackColor),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: isArabic ? 20 : 0, left: isArabic ? 0 : 20),
                        child: Row(
                          children: <Widget>[
                            SingleTap(
                                index: 0,
                                filter:
                                    sl<ECommerceCubit>().celebrityFilters[0]),
                            Container(
                                height: 25,
                                width: 1,
                                color: AppColors.blackColor,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 6)),
                            ListOfFilters(
                                filters:
                                    sl<StoreDetailCubit>().storeDetailFilters),
                          ],
                        ),
                      ),
                    ),

                    ///products
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: ProductSamples(
                          shopUUID: sl<StoreDetailCubit>().currentShopUUID!,
                          productsList: filtered),
                    ),

                    ///hot sales
                    if (sl<StoreDetailCubit>()
                        .hotDeals!
                        .isNotEmpty) ...<Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          tr("hot_deals"),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackColor),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      HotDeals(hotDeals: sl<StoreDetailCubit>().hotDeals!),
                      const SizedBox(
                        height: 32,
                      ),
                    ],

                    if (filtered.length > 2) ...<Widget>[
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ProductsList(
                            shopUUID:
                                sl<StoreDetailCubit>().currentShopUUID ?? "",
                            products: filtered.skip(2).toList(),
                          ))
                    ],

                    ///sold out products
                    if (filtered
                        .where((ProductModel element) => element.quantity == 0)
                        .isNotEmpty) ...<Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          tr("sold_out"),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.blackColor),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ProductsList(
                            shopUUID:
                                sl<StoreDetailCubit>().currentShopUUID ?? "",
                            needToShowIsSoldOut: true,
                            products: filtered
                                .where((ProductModel element) =>
                                    element.quantity == 0)
                                .toList(),
                          )),
                      const SizedBox(
                        height: 32,
                      ),
                    ],
                  ],
                ),
              );
            },
          );
        },
      ),
    );

    return BlocProvider<StoreDetailCubit>.value(
      value: sl<StoreDetailCubit>(),
      child: BlocBuilder<StoreDetailCubit, StoreDetailState>(
        builder: (BuildContext context, StoreDetailState state) {
          if (state is ShopLoading) {
            return MainScaffold(scaffold: const NativeLoading());
          }
          return MainScaffold(
            /// app bar
            appBarWidget: CelebrityAppbar(
                shopUUID: sl<StoreDetailCubit>().currentShopUUID ?? ""),
            scaffold: SingleChildScrollView(
              child: loggedInUser.token?.isNotEmpty ?? false
                  ? body
                  : GuestDialog(
                      child: body,
                    ),
            ),
          );
        },
      ),
    );
  }
}
