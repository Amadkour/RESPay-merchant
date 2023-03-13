import 'package:flutter/material.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';
import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/widget/images/my_image.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_model.dart';

class OrderProductDetailsWidget extends StatelessWidget {
  const OrderProductDetailsWidget({
    super.key,
    required this.order,
    required this.productIndex,
    this.hasStatus = true,
  });

  final OrderModel order;
  final bool hasStatus;
  final int productIndex;
  @override
  Widget build(BuildContext context) {
    final Color color = order.status == "shipped"
        ? AppColors.blueColor2
        : order.status == "canceled"
            ? AppColors.purple
            : order.status == "returned"
                ? AppColors.cyan
                : order.status == "delivered"
                    ? AppColors.greenColor
                    : AppColors.orange;
    return Row(
      children: <Widget>[
        MyImage.network(
          url: order.products.first.thumbImage,
          height: 68,
          width: 68,
          borderRadius: 8,
          fit: BoxFit.scaleDown,
          color: AppColors.greenColor,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    order.orderNumber,
                    style: smallStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.darkGrayColor,
                    ),
                  ),
                  if (hasStatus)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: color.withOpacity(0.1),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Text(
                        tr(
                          order.status ?? "",
                        ),
                        style: smallStyle.copyWith(
                          color: color,
                        ),
                      ),
                    ),
                ],
              ),
              Text(
                order.products.elementAt(productIndex).title,
                style: bodyStyle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text.rich(
                  key: const Key("detail_rich_text"),
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "${order.products.elementAt(productIndex).price}",
                        style: smallStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: tr('sar'),
                        style: smallStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: " • ",
                        style: smallStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: "${tr('qty')} : ",
                        style: smallStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text:
                            "${order.products.elementAt(productIndex).quantity}",
                        style: smallStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
        // if (hasStatus)
        //   Container(
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(40),
        //       color: color.withOpacity(0.1),
        //     ),
        //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        //     child: Text(
        //       tr(
        //         order.status ?? "",
        //       ),
        //       style: smallStyle.copyWith(
        //         color: color,
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}
