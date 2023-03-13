import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/controller/shop_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/view/component/category_filter.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/banner/banner_item_widget.dart';
import 'package:res_pay_merchant/features/search/components/build_search_bar.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<ShopCubit>(
        create: (BuildContext context) => ShopCubit(),
        child: BlocBuilder<ShopCubit, ShopState>(
          builder: (BuildContext context, ShopState state) {
            final ShopCubit controller = context.read<ShopCubit>();
            return MainScaffold(
              scaffold: Scaffold(
                body: SingleChildScrollView(
                  key: shopScrollKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: (controller.shops.banners?.length ?? 0) > 0
                                ? PageView.builder(
                                    onPageChanged: controller.onChangeImage,
                                    itemCount: controller.shops.banners?.length ?? 0,
                                    itemBuilder: (BuildContext context, int index) {
                                      return BannerWidget(offerModel: controller.shops.banners![index]);
                                    })
                                : const Center(
                                    child: Text(
                                      'No Offers Available',
                                      style: TextStyle(),
                                    ),
                                  ),
                          ),

                          ///indicator
                          Positioned(
                            left: 0.0,
                            right: 0.0,
                            bottom: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List<Widget>.generate(
                                controller.shops.banners?.length ?? 0,
                                (int index) => Container(
                                  height: 8,
                                  width: controller.pageValue == index ? 17 : 8,
                                  margin: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.blackColor.withAlpha(controller.pageValue == index ? 255 : 125),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          tr('shop'),
                          style: TextStyle(fontSize: 20, color: AppColors.blackColor, fontFamily: 'SemiBold'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: SearchBar(
                            hintText:tr("Search Store or Product"),
                            onChanged: controller.onChangeSearch,
                            backGroundColor: Colors.white,
                            verticalPadding: 20,
                            showClear: controller.searchBarController.text.isEmpty,
                            controller: controller.searchBarController,
                            onClear: () {
                              controller.resetSearchBar();
                            },
                        ),
                      ),
                      if (controller.shops.shops != null)
                        Padding(
                            padding: const EdgeInsets.only(bottom: 32, left: 10, right: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List<CategoryFilter>.generate(
                                    controller.shops.shopCategories!.length,
                                    (int index) => CategoryFilter(
                                          key: Key('category_item$index'),
                                          value: controller.shops.shopCategories![index],
                                          onPressed: () => controller.changeCategory(index),
                                        )).toList(),
                              ),
                            )),
                      if (state is ShopLoading)
                        const NativeLoading()
                      else if (controller.shops.shops?.isNotEmpty ?? false)
                        ...List<Widget>.generate(
                          controller.categoryFilteredList.length,
                          (int index) => Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: InkWell(
                              key: Key("shop_at_index_$index"),
                              onTap: () {
                                ///go to brand

                                CustomNavigator.instance.pushNamed(RoutesName.storeDetails,
                                    arguments: <String, dynamic>{
                                      "shopSlug":controller.categoryFilteredList[index].slug,
                                    });
                              },
                              child: Container(
                                padding: const EdgeInsets.only(left: 14, right: 14, top: 20, bottom: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  leading: SizedBox(
                                    width: 45,
                                    height: 45,
                                    child: MyImage.network(
                                      url: controller.categoryFilteredList[index].icon,
                                      height: 45,
                                      width: 45,
                                      borderRadius: 45,
                                    ),
                                  ),
                                  title: AutoSizeText(
                                    controller.categoryFilteredList[index].name.toString(),
                                    style: TextStyle(fontSize: 16, color: AppColors.blackColor, fontFamily: 'Bold'),
                                  ),
                                  subtitle: AutoSizeText(
                                    controller.shops.shops![index].shopCategoryName ?? "",
                                    style: TextStyle(fontSize: 12, color: AppColors.textColor3, fontFamily: 'Plain'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      else ...<Widget>[
                        const Center(
                          child: Text(
                            'No Shops Available',
                            style: TextStyle(),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    CustomNavigator.instance.pushNamed(RoutesName.videoList);
                  },
                  tooltip: 'Increment',
                  backgroundColor: AppColors.blackColor,
                  child: const Icon(
                    Icons.shop,
                    size: 27,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
