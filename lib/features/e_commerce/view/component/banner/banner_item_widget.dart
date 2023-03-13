import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/provider/module/shop_model.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class BannerWidget extends StatelessWidget {
  final Banners offerModel;
  const BannerWidget({super.key, required this.offerModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        CustomNavigator.instance
            .pushNamed(RoutesName.storeDetails, arguments: <String, dynamic>{
          "shopSlug": offerModel.shopSlug,
        });
      },
      child: Stack(
        alignment: !isArabic ? Alignment.topLeft : Alignment.topRight,
        children: <Widget>[
          SizedBox.expand(
              child: MyImage.network(
            url: offerModel.image,
            borderRadius: 0,
          )),
        ],
      ),
    );
  }
}
