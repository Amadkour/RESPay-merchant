import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';

import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/product/product_favorite_indicator.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class ProductItemInColum extends StatelessWidget {
  const ProductItemInColum(
      {super.key,
      this.needToShowIsSoldOut = false,
      required this.cartIconKey,
      required this.shopUUID,
      required this.productModel,
      required this.favouriteIconKey});

  final ProductModel productModel;
  final String favouriteIconKey;
  final String cartIconKey;
  final bool needToShowIsSoldOut;
  final String shopUUID;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key(cartIconKey),
      onTap: () => CustomNavigator.instance.pushNamed(RoutesName.product,
          arguments: <String, dynamic>{
            "product": productModel,
            "shopUUID": shopUUID
          }),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              height: 160,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16), // Image border
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, top: 8, right: 15, bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      /// product header
                      Row(
                        children: <Widget>[
                          if (needToShowIsSoldOut &&
                              productModel.quantity == 0) ...<Widget>[
                            Container(
                                width: 65,
                                height: 24,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: const Color(0xffD55353)
                                        .withOpacity(0.1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16))),
                                child: Center(
                                  child: AutoSizeText(tr("sold_out"),
                                      style: const TextStyle(
                                          color: Color(0xffD55353),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600)),
                                )),
                          ],
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: SizedBox(
                              height: 20,
                              child: ProductFavoriteIndicator(
                                  product: productModel,
                                  itemKey: favouriteIconKey),
                            ),
                          ),
                        ],
                      ),

                      /// product image
                      Expanded(
                        child: MyImage.network(
                          width: context.width,
                          fit: BoxFit.contain,
                          url: productModel.thumbImage,
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          /// product info (price , name)
          const SizedBox(
            height: 12,
          ),
          AutoSizeText(
              "${productModel.salesPrice ?? productModel.price} ${tr("SAR")}",
              maxLines: 1,
              style: TextStyle(
                  color: AppColors.blackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 4,
          ),
          AutoSizeText(productModel.name,
              maxLines: 1,
              style: const TextStyle(
                  color: Color(0xff5A6367),
                  fontSize: 12.8,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
