import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/appbar/e_commerce_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/dialogs/guest_dialog.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';
import 'package:res_pay_merchant/features/e_commerce/controller/e_commerce_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/controller/cart_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/controller/celebrity_list_controller/celebrity_cubit_state.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/provider/model/celebrity.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/celebrity/view/component/celebrity_detail/celebrity_info_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/banner/banner_list_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/filter/list_of_product_filters.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/product/products_list.dart';

class CelebrityDetail extends StatelessWidget {
  const CelebrityDetail({super.key, required this.currentCelebrity});

  final Celebrity currentCelebrity;

  @override
  Widget build(BuildContext context) {
    final Widget body = MultiBlocProvider(
        providers: <BlocProvider<dynamic>>[
          BlocProvider<CelebrityCubit>.value(
              value: sl<CelebrityCubit>()
                ..getCelebrityProducts(
                    celebrityUuid: currentCelebrity.id ?? "")),
          BlocProvider<CartCubit>.value(value: sl<CartCubit>()),
        ],
        child: BlocBuilder<CelebrityCubit, CelebrityState>(
          builder: (BuildContext context, CelebrityState state) {
            if (state is CelebrityDetailLoading) {
              return const NativeLoading();
            }
            return ColoredBox(
              color: AppColors.lightWhite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// current celebrity info
                  CelebrityInfoWidget(currentCelebrity: currentCelebrity),

                  /// banners page view
                  // sl<CelebrityDetailCubit>().banners.isNotEmpty
                  //     ?
                  if (sl<CelebrityCubit>().banners.isNotEmpty)
                    BannerListWidget(offers: sl<CelebrityCubit>().banners)
                  // : EmptyWidget(message: tr("no_offers_now"),height: 0,
                  // )
                  ,
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

                  /// filters options
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListOfFilters(
                      filters: sl<ECommerceCubit>().celebrityFilters,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),

                  /// products list
                  BlocBuilder<CartCubit, CartState>(
                    buildWhen: (CartState previous, CartState current) =>
                        sl<CartCubit>().cartModel != null,
                    builder: (BuildContext context, CartState state) {
                      if (state is CartLoading) {
                        return const NativeLoading();
                      }
                      return sl<CelebrityCubit>().products?.isNotEmpty ?? false
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ProductsList(
                                shopUUID: currentCelebrity.id!,
                                products: sl<CelebrityCubit>().products!,
                              ))
                          : EmptyWidget(
                              message:
                                  tr("no_products_for_this_celebrity_now"));
                    },
                  ),
                ],
              ),
            );
          },
        ));
    return MainScaffold(
      /// app bar
      appBarWidget: CelebrityAppbar(
        title: "celebrity",
        shopUUID: currentCelebrity.id!,
      ),
      scaffold: SingleChildScrollView(
          child: loggedInUser.token?.isNotEmpty ?? false
              ? body
              : GuestDialog(child: body)),
    );
  }
}
