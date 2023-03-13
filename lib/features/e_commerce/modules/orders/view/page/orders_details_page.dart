import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/res/theme/colors.dart';

import 'package:res_pay_merchant/core/res/utils/extenstions.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/appbar/custom_appbar.dart';
import 'package:res_pay_merchant/core/widget/base_page.dart';
import 'package:res_pay_merchant/core/widget/bottom_sheet/base_bottom_sheet.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/loading.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/controller/cart_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/cart_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/controller/orders_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/components/cancel_sheet.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/components/complain_sheet.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/components/order_payment_info_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/components/order_product_details_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/components/order_user_details_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/components/stepper_widget.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/view/component/container_with_shadow_widget.dart';

import 'package:res_pay_merchant/routes/routes_name.dart';

class OrderDetailsPage extends StatelessWidget {
  OrderDetailsPage({
    super.key,
  });
  final GlobalKey<FormState> cancelReasonKey = GlobalKey<FormState>();
  final GlobalKey<FormState> complainKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final OrdersCubit orderController = sl<OrdersCubit>();
    return BlocProvider<OrdersCubit>.value(
      value: orderController,
      child: MainScaffold(
        appBarWidget: MainAppBar(
          title: tr('detail_order'),
        ),
        scaffold: BlocConsumer<OrdersCubit, OrdersState>(
          listener: (BuildContext context, OrdersState state) {
            if (state is SingleOrderFailure) {
              MyToast(state.failure.message);
            } else if (state is OrderCanceled) {
              MyToast.success(tr("order_canceled"));
            } else if (state is OrderComplained) {
              MyToast.success(tr("complain_sent"));
            }
          },
          builder: (BuildContext context, OrdersState state) {
            if (state is SingleOrderLoading) {
              return const NativeLoading();
            }
            final OrderModel order = orderController.order;
            log('rebuild');
            return OrderDetailsBody(
              order: order,
              orderController: orderController,
              cancelReasonKey: cancelReasonKey,
              complainKey: complainKey,
              state: state,
            );
          },
        ),
      ),
    );
  }
}

class OrderDetailsBody extends StatelessWidget {
  const OrderDetailsBody({
    super.key,
    required this.order,
    required this.orderController,
    required this.cancelReasonKey,
    required this.state,
    required this.complainKey,
  });

  final OrderModel order;
  final OrdersCubit orderController;
  final GlobalKey<FormState> cancelReasonKey;
  final OrdersState state;
  final GlobalKey<FormState> complainKey;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: orderDetailsScrollViewKey,
      child: Column(
        children: <Widget>[
          //------Order Details Widget------///
          ContainerWithShadow(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            margin: const EdgeInsets.all(16),
            child: Theme(
              data: context.theme.copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                key: const Key("expansion_tile_detail_order"),
                iconColor: context.theme.primaryColor,
                title: Text(
                  tr('detail_order'),
                  style: context.theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                initiallyExpanded: true,
                children: <Widget>[
                  ///--------Order Products ------//
                  Column(
                    children: List<Widget>.generate(
                      order.products.length,
                      (int index) => Column(
                        children: <Widget>[
                          OrderProductDetailsWidget(
                            hasStatus: index == 0,
                            productIndex: index,
                            order: order,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Divider(
                              color: AppColors.borderColor,
                              thickness: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  OrderUserDetailsWidget(
                    order: order,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Divider(
                      color: AppColors.borderColor,
                      thickness: 1.2,
                    ),
                  ),
                  PaymentSummaryWidget(order: order),
                ],
              ),
            ),
          ),

          //-------Tracking Widget-----//
          ContainerWithShadow(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 30),
            child: Theme(
              data: context.theme.copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                initiallyExpanded: true,
                iconColor: context.theme.primaryColor,
                subtitle: Text(
                  order.estimateDeliveryDate != null
                      ? "${tr('estimated_received')} ${DateFormat('dd MMMM yyyy').format(order.estimateDeliveryDate!)}"
                      : "",
                  style: TextStyle(
                    color: AppColors.darkGrayColor,
                  ),
                ),
                title: Text(
                  tr('tracking_order'),
                  style: context.theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                children: <Widget>[
                  HorizontalStepper(
                    orderController: orderController,
                  ),
                  if (order.timeline.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.borderColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: StepperWidget(
                        order: order,
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (orderController.isOrderProcessing)
                    LoadingButton(
                      key: cancelOrderButtonKey,
                      hasBottomSaveArea: false,
                      topPadding: 0,
                      isLoading: false,
                      title: tr('cancel'),
                      onTap: () {
                        showCustomBottomSheet(
                          context: context,
                          body: CancelSheet(
                            orderCubit: orderController,
                            formKey: cancelReasonKey,
                          ),
                          autoClose: false,
                          title: tr('reason_for_cancellation'),
                          onPressed: () async {
                            if (cancelReasonKey.currentState!.validate()) {
                              CustomNavigator.instance.pop();
                              await orderController.cancelOrder();
                            }
                          },
                        );
                      },
                    ),

                  //TODO remove comments when is complete return from api
                  if (orderController.order.status == "delivered") ...<Widget>[
                    // if (orderController.order.isComplete)
                    // LoadingButton(
                    //   key: buyAgainButtonKey,
                    //   hasBottomSaveArea: false,
                    //   onTap: () async {
                    //     final bool result = await orderController.buyAgain(order.uuid);
                    //     if (result) {
                    //       CustomNavigator.instance.pushNamed(RoutesName.checkout);
                    //     }
                    //   },
                    //   height: 40,
                    //   topPadding: 16,
                    //   title: tr('buy_again'),
                    //   isLoading: state is OrderBoughtAgainLoading,
                    // )
                    // else
                    ...<Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 10),
                      //   child: LoadingButton(
                      //     hasBottomSaveArea: false,
                      //     topPadding: 0,
                      //     isLoading: false,
                      //     title: tr('complete_order'),
                      //     onTap: () {},
                      //   ),
                      // ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: LoadingButton(
                          key: buyAgainButtonKey,
                          hasBottomSaveArea: false,
                          onTap: () async {
                            await buyAgain(orderController, order);
                          },
                          height: 40,
                          topPadding: 16,
                          title: tr('buy_again'),
                          isLoading: state is OrderBoughtAgainLoading,
                        ),
                      ),
                      LoadingButton(
                        key: complainButtonKey,
                        hasBottomSaveArea: false,
                        backgroundColor: Colors.white,
                        borderColor: AppColors.borderColor,
                        fontColor: context.theme.primaryColor,
                        topPadding: 0,
                        isLoading: false,
                        title: tr('complain_order'),
                        onTap: () {
                          showCustomBottomSheet(
                            context: context,
                            body: ComplainOrderSheetWidget(
                              formKey: complainKey,
                              onDescriptionChanged: (String value) {
                                orderController.complainReason = value;
                              },
                              onComplainTypeChanged: (String v) {
                                orderController.complainReasonType = v;
                              },
                            ),
                            hasButtons: false,
                            autoClose: false,
                            title: tr('reason_for_complain'),
                          );
                        },
                      ),
                    ]
                  ]
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future<void> buyAgain(OrdersCubit orderController, OrderModel order) async {
  final CartModel? result = await orderController.buyAgain(order.uuid);
  if (result != null) {
    sl<CartCubit>().cartModel = result;
    CustomNavigator.instance.pushNamed(RoutesName.checkout);
  }
}
