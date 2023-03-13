import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/res/utils/extenstions.dart';

import 'package:res_pay_merchant/core/services/navigation.dart';

import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/controller/orders_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/components/order_product_details_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/page/orders_details_page.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/container_with_shadow_widget.dart';

import 'package:res_pay_merchant/routes/routes_name.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget(
      {super.key, required this.order, required this.ordersController});

  final OrderModel order;
  final OrdersCubit ordersController;

  @override
  Widget build(BuildContext context) {
    return ContainerWithShadow(
      margin: const EdgeInsets.only(top: 16, left: 20, right: 20),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            child: OrderProductDetailsWidget(
              order: order,
              productIndex: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: LoadingButton(
                    key: viewOrderDetailsButtonKey,
                    onTap: () {
                      ordersController.track(order);
                      CustomNavigator.instance
                          .pushNamed(
                        RoutesName.orderDetails,
                      )
                          .then((_) {
                        ordersController.getOrders();
                      });
                    },
                    hasBottomSaveArea: false,
                    topPadding: 16,
                    height: 40,
                    borderColor: AppColors.borderColor,
                    backgroundColor: Colors.white,
                    title: tr('detail_order'),
                    fontColor: context.theme.primaryColor,
                    isLoading: false,
                  ),
                ),
                if (order.status == "delivered") ...<Widget>[
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: BlocBuilder<OrdersCubit, OrdersState>(
                      builder: (BuildContext context, OrdersState state) =>
                          LoadingButton(
                        key: buyAgainButtonKey,
                        hasBottomSaveArea: false,
                        onTap: () async {
                          await buyAgain(ordersController, order);
                        },
                        height: 40,
                        topPadding: 16,
                        title: tr('buy_again'),
                        isLoading: state is OrderBoughtAgainLoading,
                      ),
                    ),
                  )
                ],
              ],
            ),
          )
        ],
      ),
    );
  }
}
