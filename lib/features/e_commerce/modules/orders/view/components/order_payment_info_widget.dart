import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/res/theme/font_styles.dart';

import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_model.dart';

class PaymentSummaryWidget extends StatelessWidget {
  const PaymentSummaryWidget({
    super.key,
    required this.order,
  });

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            tr('summary'),
            style: bodyStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              tr('subtotal'),
              style: bodyStyle.copyWith(
                color: AppColors.darkGrayColor,
              ),
            ),
            Text(
              "${order.subTotal}${tr('sar')}",
              style: bodyStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              tr('tax'),
              style: bodyStyle.copyWith(
                color: AppColors.darkGrayColor,
              ),
            ),
            Text(
              "${order.taxes}${tr('sar')}",
              style: bodyStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              tr('shipment_fee'),
              style: bodyStyle.copyWith(
                color: AppColors.darkGrayColor,
              ),
            ),
            Text(
              "${order.shipping}${tr('sar')}",
              style: bodyStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              tr('discount'),
              style: bodyStyle.copyWith(
                color: AppColors.darkGrayColor,
              ),
            ),
            Text(
              "${order.discount}${tr('sar')}",
              style: bodyStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Divider(
            color: AppColors.borderColor,
            thickness: 1.2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                tr('total'),
                style: bodyStyle.copyWith(
                  color: AppColors.darkGrayColor,
                ),
              ),
              Text(
                "${order.total}${tr('sar')}",
                style: bodyStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
