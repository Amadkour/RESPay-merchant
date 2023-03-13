import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/decoration_values.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/controller/promotions_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/promotions_model.dart';
import 'package:res_pay_merchant/routes/routes_name.dart';

class SinglePromotionItem extends StatelessWidget {
  const SinglePromotionItem({
    required this.singlePromotion,
    required this.index,
    super.key,
  });
  final SinglePromotion singlePromotion;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      key: Key("promo_code_at_index_$index"),
      onTap: () {

        CustomNavigator.instance.pushNamed(RoutesName.storeDetails,
            arguments: <String, dynamic>{
              "shopSlug":(sl<PromotionsCubit>().promotionsModel!.promotions![index] as SinglePromotion).shopSlug,
            });
      },
      child:Container(
        padding: const EdgeInsets.only(top: 12,bottom: 12),
        height: 85,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: defaultBorderRadius
        ),
        child: Row(
          children: <Widget>[
            const SizedBox(
              width: 14,
            ),
            CircleAvatar(
              backgroundColor: Colors.white,
              child: MyImage.network(
                borderRadius: 100.0,
                width: 55.0,
                height: 55,
                url: singlePromotion.shopIcon,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: AutoSizeText(
                              minFontSize: 15,
                              singlePromotion.shopName!,
                              style: TextStyle(
                                  color: AppColors.blackColor,
                                  fontWeight: FontWeight.bold),maxLines: 1),
                        ),
                        const SizedBox(width: 15,),
                        Container(
                          height: 25,
                          width: 40,
                          decoration: BoxDecoration(
                              color: const Color(0xffEDEDED),
                              borderRadius: isArabic?const BorderRadius.only(topRight: Radius.circular(40),bottomRight: Radius.circular(40)):const BorderRadius.only(topLeft: Radius.circular(40),bottomLeft: Radius.circular(40))
                          ),
                          child: Center(child: FittedBox(
                            child: AutoSizeText(
                              minFontSize: 11,
                              "x${singlePromotion.offerCount!}",
                              style: const TextStyle(
                                  color: Color(0xff161B28),fontSize: 11,fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText(singlePromotion.value!,
                      style: TextStyle(
                          fontSize: 10,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500),maxFontSize: 10,maxLines: 1,minFontSize: 10,),
                  ),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        MyImage.svgAssets(url: "assets/icons/transfer/timer.svg",width: 10,height: 10,color: const Color(0xffD55353)),
                        const SizedBox(width: 4,),
                        AutoSizeText(singlePromotion.validTo!,
                          style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xffD55353),
                              fontWeight: FontWeight.w600),maxFontSize: 11,maxLines: 1,minFontSize: 11,),
                      ],
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
