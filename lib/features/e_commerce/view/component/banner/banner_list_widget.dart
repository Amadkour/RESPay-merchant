import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/provider/module/shop_model.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/banner/banner_item_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerListWidget extends StatelessWidget {
  BannerListWidget({super.key, required this.offers});
  final List<Banners> offers;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 200,
          child: PageView.builder(
            itemCount: offers.length,
            controller: _pageController,
            itemBuilder: (BuildContext context, int index) {
              return BannerWidget(offerModel: offers[index]);
            },
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        offers.isNotEmpty
            ? SmoothPageIndicator(
                controller: _pageController, // PageController
                count: offers.length,
                effect: SlideEffect(
                  dotHeight: 9,
                  dotWidth: 9,
                  dotColor: AppColors.blackColor.withOpacity(0.5),
                  activeDotColor: AppColors.blackColor,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
