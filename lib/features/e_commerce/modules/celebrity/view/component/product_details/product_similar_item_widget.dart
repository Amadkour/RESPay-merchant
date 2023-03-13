import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/product/product_favorite_indicator.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

class SimilarProductWidget extends StatelessWidget {
  const SimilarProductWidget({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => CustomNavigator.instance
          .pushNamed(RoutesName.product, arguments: product),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.borderColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        margin: const EdgeInsetsDirectional.only(end: 20, bottom: 12),
        width: context.isTablet ? context.width * 0.4 : context.width * 0.70,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 80,
              height: 80,
              child: MyImage.assets(
                url: product.images.first,
                height: 50,
                width: 70,
                fit: BoxFit.scaleDown,
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child:
                        ProductFavoriteIndicator(product: product, itemKey: ""),
                  ),
                  Text(
                    "${product.price} ${tr('sar')}",
                    style: bodyStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    product.name,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
