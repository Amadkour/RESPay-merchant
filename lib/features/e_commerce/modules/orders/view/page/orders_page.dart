import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/res/theme/font_styles.dart';
import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/widget/alternative_widgets/empty_widget.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/controller/orders_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/components/order_list_widget.dart';
import 'package:res_pay_merchant/features/search/components/build_search_bar.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      appBarWidget: MainAppBar(
        title: tr("my_orders"),
      ),
      scaffold: BlocProvider<OrdersCubit>.value(
          value: sl<OrdersCubit>()
            ..filterStatus = null
            ..getOrders(),
          child: SingleChildScrollView(
            child: BlocConsumer<OrdersCubit, OrdersState>(
              listener: (BuildContext context, OrdersState state) {
                if (state is OrderBoughtAgainError || state is OrdersFailure) {
                  MyToast((state as OrdersFailure).failure.message);
                }
              },
              builder: (BuildContext context, OrdersState state) {
                final OrdersCubit ordersController =
                    context.read<OrdersCubit>();
                if (state is OrdersLoading) {
                  return const NativeLoading();
                }
                return MyOrdersListBody(ordersController: ordersController);
              },
            ),
          )),
    );
  }
}

class MyOrdersListBody extends StatelessWidget {
  const MyOrdersListBody({
    super.key,
    required this.ordersController,
  });

  final OrdersCubit ordersController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (ordersController.showOrdersFilters) ...<Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
            child: SearchBar(
                key: orderSearchTextFieldKey,
                verticalPadding: 20,
                backGroundColor: Colors.white,
                onClear: () {
                  ordersController.resetSearchBar();
                },
                showClear: ordersController.searchBarController.text.isEmpty,
                hintText: "search_order",
                onChanged: (String value) {
                  ordersController.search(value);
                },
                controller: ordersController.searchBarController),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 20, top: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: <Widget>[
                          OrderStatusFilterWidget(
                            key: const ValueKey<String>("all_orders"),
                            name: "all_orders",
                            isActive: ordersController.filterStatus == null,
                            onPressed: () {
                              ordersController.filterStatus = null;
                            },
                          )
                        ] +
                        ordersController.model.status.map((String e) {
                          return OrderStatusFilterWidget(
                            key: ValueKey<String>(e),
                            name: e,
                            isActive: ordersController.filterStatus == e,
                            onPressed: () {
                              ordersController.filterStatus = e;
                            },
                          );
                        }).toList()),
              ),
            ),
          ),
        ],
        if (ordersController.orders.isEmpty)
          EmptyWidget(
            width: context.width * .5,
            height: context.width * .5,
            message: tr('no_orders'),
            subMessage: tr('no_orders_description'),
          )
        else
          OrderListWidget(
            orders: ordersController.orders,
            ordersCubit: ordersController,
          ),
      ],
    );
  }
}

class OrderStatusFilterWidget extends StatelessWidget {
  const OrderStatusFilterWidget({
    super.key,
    required this.name,
    required this.isActive,
    required this.onPressed,
  });
  final String name;
  final bool isActive;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 6),
        margin: const EdgeInsetsDirectional.only(end: 8),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.greenColor.withOpacity(0.2)
              : AppColors.unSelectedFilterBackground,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          tr(name),
          style: bodyStyle.copyWith(
            color: isActive ? AppColors.greenColor : AppColors.secondaryColor,
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
