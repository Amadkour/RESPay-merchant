import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';

import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class ProductItemInRowView extends StatelessWidget {
  final ProductModel product;
  final int itemIndex;
  const ProductItemInRowView(
      {super.key, required this.product, required this.itemIndex});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => CustomNavigator.instance
          .pushNamed(RoutesName.product, arguments: product),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.borderColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        width: context.isTablet ? size.width * 0.4 : size.width * 0.70,
        child: Row(
          children: <Widget>[
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16), // Image border
                  child: MyImage.assets(
                    url: product.images.first,
                  ),
                )),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: MyImage.svgAssets(
                          url: "assets/icons/e_commerce/editicon.svg"),
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      "${product.price} ${tr('sar')}",
                      style: bodyStyle.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(
                      overflow: TextOverflow.ellipsis,
                      product.name,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
