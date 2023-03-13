import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/controller/promotions_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/view/components/single_promotion_item.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/promotions_model.dart';
import 'package:res_pay_merchant/features/e_commerce/view/component/filter/list_of_product_filters.dart';

class PromotionsListWidget extends StatelessWidget {
  const PromotionsListWidget({super.key, required this.filteredPromotions,required this.promotionsCubit});

  final List<SinglePromotion> filteredPromotions;
  final PromotionsCubit promotionsCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height,
      width: context.width,
      color: const Color(0xffF1F3F6),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (filteredPromotions.isEmpty)...<Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  EmptyWidget(
                    message: tr("no_promotions_yet"),
                    height: context.height *0.3,
                  ),
                ],
              ),
            )
          ]
          else ...<Widget>[
            const SizedBox(
              height: 24,
            ),
            ListOfFilters(
              filters: promotionsCubit.filters,
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
                child: ListOfPromotions(filteredPromotions: filteredPromotions)
            ),
            const SizedBox(
              height: 24,
            ),
          ]
        ],
      ),
    );
  }
}

class ListOfPromotions extends StatelessWidget {
  const ListOfPromotions({
    super.key,
    required this.filteredPromotions,
  });

  final List<SinglePromotion> filteredPromotions;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) =>
            SinglePromotionItem(
                key: index == 0 ? promotionItemKey : null,
                index: index,
                singlePromotion: filteredPromotions[index]),
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 12),
        itemCount: filteredPromotions.length);
  }
}
