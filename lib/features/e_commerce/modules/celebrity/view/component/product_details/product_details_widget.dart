import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/product/product_favorite_indicator.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AutoSizeText(
                  product.name,
                  style: header5Style.copyWith(
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${product.salesPrice ?? product.price} ${tr('sar')}",
                  style: bodyStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (product.salesPrice != null &&
                    product.price != product.salesPrice)
                  Row(
                    children: <Widget>[
                      Text(
                        "${product.price} ${tr('sar')}",
                        style: TextStyle(
                          color: context.theme.dividerColor,
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 3,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsetsDirectional.only(start: 4),
                        decoration: BoxDecoration(
                          color: AppColors.greenColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Center(
                          child: Text(
                            "-${(product.discountPercentage * 100).toStringAsFixed(1)} %",
                            style: smallStyle.copyWith(
                              fontWeight: FontWeight.normal,
                              color: AppColors.greenColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (product.quantity == 0) ...<Widget>[
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: const Color(0xffD55353).withOpacity(0.1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    height: 32,
                    child: Row(
                      children: <Widget>[
                        MyImage.svgAssets(
                            url: "assets/icons/e_commerce/soldout.svg",
                            height: 12,
                            width: 12,
                            color: const Color(0xffD55353)),
                        const SizedBox(
                          width: 4,
                        ),
                        AutoSizeText(
                            tr(
                              "item_sold_out_please_choose_another_item",
                            ),
                            style: const TextStyle(
                                color: Color(0xffD55353),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                            maxFontSize: 13,
                            maxLines: 1),
                      ],
                    ),
                  )
                ]
              ],
            ),
          ),
          ProductFavoriteIndicator(
            product: product,
            itemKey: "favourite_icon_in_product_details",
          )
        ],
      ),
    );
  }
}
