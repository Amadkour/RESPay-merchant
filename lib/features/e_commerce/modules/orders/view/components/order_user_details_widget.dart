import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';

import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_model.dart';

class OrderUserDetailsWidget extends StatelessWidget {
  const OrderUserDetailsWidget({
    super.key,
    required this.order,
  });
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text(
            tr('order_by'),
            style: bodyStyle.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.darkGrayColor,
            ),
          ),
          subtitle: Text(
            loggedInUser.name ?? "",
            style: bodyStyle.copyWith(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text(
            tr('phone_number').toUpperCase(),
            style: bodyStyle.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.darkGrayColor,
            ),
          ),
          subtitle: Text(
            loggedInUser.phone ?? "",
            style: bodyStyle.copyWith(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text(
            tr('date').toUpperCase(),
            style: bodyStyle.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.darkGrayColor,
            ),
          ),
          subtitle: order.timeline.isNotEmpty
              ? Text(
                  DateFormat('dd MMMM yyyy').format(order.timeline.first.date),
                  style: bodyStyle.copyWith(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ))
              : const SizedBox(),
        ),
        ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
            title: Text(
              tr('address').toUpperCase(),
              style: bodyStyle.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.darkGrayColor,
              ),
            ),
            subtitle: Text(
              order.address?.streetName! ?? "",
              style: bodyStyle.copyWith(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            )),
      ],
    );
  }
}
