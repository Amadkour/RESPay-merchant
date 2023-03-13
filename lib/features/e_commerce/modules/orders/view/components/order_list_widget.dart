import 'package:flutter/material.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/controller/orders_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/components/order_widget.dart';

class OrderListWidget extends StatelessWidget {
  const OrderListWidget({
    super.key,
    required this.ordersCubit,
    required this.orders,
  });

  final List<OrderModel> orders;
  final OrdersCubit ordersCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List<Widget>.generate(orders.length, (int index) {
        final OrderModel order = orders.elementAt(index);
        return OrderWidget(order: order,ordersController: ordersCubit,);
      }),
    );
  }
}
