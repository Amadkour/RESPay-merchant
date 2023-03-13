import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/child/description_text_field.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';

import 'package:res_pay_merchant/features/dashboard/modules/more/modules/shipping_location/provider/model/address_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/controller/orders_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_item_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_list_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/tracking_stage_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/components/cancel_sheet.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/components/order_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/components/stepper_widget.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/page/orders_details_page.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/view/page/orders_page.dart';
import 'package:res_pay_merchant/features/search/components/build_search_bar.dart';

import 'package:res_pay_merchant/routes/router.dart';
import '../../../../../../integration_test/helper/helper.dart';
import '../../../../../../integration_test/shared/values.dart';
import 'my_orders_screen_test.mocks.dart';

@GenerateMocks(<Type>[OrdersCubit])
void main() {
  late MockOrdersCubit mockOrdersCubit;
  final List<OrderModel> ordersList = <OrderModel>[
    OrderModel(
        address: AddressModel(streetName: "test street"),
        timeline: <TrackingStageModel>[
          TrackingStageModel(
            status: "pending",
            date: DateTime.now(),
          ),
        ],
        uuid: "ordersUUID1",
        products: <OrderItemModel>[
          OrderItemModel(
              productUUid: "product1",
              uuid: "productUUID1",
              title: "title",
              price: 200,
              thumbImage: "thumbImage",
              quantity: 1)
        ],
        addressUuid: 'testAddressUuid',
        paymentMethodUuid: 'testPaymentMethodUuid',
        subTotal: 100,
        taxes: 2,
        shipping: 1,
        estimateDeliveryDate: DateTime.now(),
        discount: 2,
        total: 200,
        orderNumber: 'order1')
  ];
  setUp(() {
    mockOrdersCubit = MockOrdersCubit();
    when(mockOrdersCubit.state).thenReturn(OrdersInitial());
    final Stream<OrdersState> stream =
        Stream<OrdersState>.fromIterable(<OrdersState>[
      OrdersInitial(),
      OrdersLoading(),
      OrdersLoaded(),
    ]);

    when(mockOrdersCubit.stream).thenAnswer(
      (Invocation i) => stream,
    );
    when(mockOrdersCubit.orders).thenReturn(ordersList);
    when(mockOrdersCubit.query).thenReturn("order1");
    when(mockOrdersCubit.filterStatus).thenReturn("pending");
    when(mockOrdersCubit.isOrderProcessing).thenReturn(true);
    when(mockOrdersCubit.order).thenReturn(ordersList.first);
    when(mockOrdersCubit.orderCompleted).thenReturn(false);
    when(mockOrdersCubit.orderShipped).thenReturn(false);
    when(mockOrdersCubit.model).thenReturn(OrderListModel(
        orders: ordersList,
        status: <String>["pending", "received", "delivered", "completed"]));
    when(mockOrdersCubit.searchBarController)
        .thenReturn(TextEditingController());
    when(mockOrdersCubit.showOrdersFilters).thenReturn(true);
  });
  group('testing Order List screen', () {
    testWidgets('testing FaqCubit view', (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider<OrdersCubit>(
        create: (BuildContext context) => mockOrdersCubit,
        child: MaterialApp(
          onGenerateRoute: (RouteSettings settings) =>
              AppRouter.router(settings),
          navigatorKey: globalKey,
          home: Scaffold(
              body: MyOrdersListBody(
            ordersController: mockOrdersCubit,
          )),
        ),
      ));
      expect(find.text(tr("search_order")), findsOneWidget);
      expect(find.byType(SearchBar), findsOneWidget);
      expect(
          tester.widgetList(find.bySubtype<OrderStatusFilterWidget>()).length,
          5);
      expect(tester.widgetList(find.bySubtype<OrderWidget>()).length, 1);
      await tester.enterText(
          find.byType(ParentTextField), mockOrdersCubit.query);
      expect(tester.widgetList(find.text('order1')).length, 2);
      expect(
          find
              .widgetWithText(LoadingButton, tr('detail_order'))
              .evaluate()
              .toList()
              .length,
          1);
      await tester.tap(find.byKey(viewOrderDetailsButtonKey));
    });

    testWidgets('testing Order Detail view', (WidgetTester tester) async {
      loggedInUser.name = "mohamed";
      await buildBody(tester, mockOrdersCubit, ordersList);
      expect(tester.widgetList(find.byType(ExpansionTile)).length, 2);
      expect(
          find
              .widgetWithText(LoadingButton, tr('cancel'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(ExpansionTile, tr('detail_order'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(ExpansionTile, tr('tracking_order'))
              .evaluate()
              .toList()
              .length,
          1);
      await tester.tap(find.byKey(const Key("expansion_tile_detail_order")));
      await tester.pump();
      await tester.tap(find.byKey(const Key("expansion_tile_detail_order")));
      expect(find.text(ordersList.first.orderNumber), findsOneWidget);
      expect(find.text(ordersList.first.products.first.title), findsOneWidget);
      expect(find.byKey(const Key("detail_rich_text")), findsOneWidget);
      expect(find.text(tr('order_by')), findsOneWidget);
      expect(find.text(loggedInUser.name!), findsOneWidget);
      expect(find.text(tr('phone_number').toUpperCase()), findsOneWidget);
      expect(find.text(tr('date').toUpperCase()), findsOneWidget);
      expect(
          find.text(DateFormat('dd MMMM yyyy')
              .format(ordersList.first.timeline.first.date)),
          findsOneWidget);
      expect(find.text(tr('address').toUpperCase()), findsOneWidget);
      expect(find.text(ordersList.first.address!.streetName!), findsOneWidget);
      expect(
          find.text(
              "${tr('estimated_received')} ${DateFormat('dd MMMM yyyy').format(ordersList.first.estimateDeliveryDate!)}"),
          findsOneWidget);
      expect(find.byType(HorizontalStepper), findsOneWidget);
      expect(tester.widgetList(find.byType(HorizontalStepperItem)).length, 3);
      expect(find.text(tr('status_details')), findsOneWidget);
      expect(
          find
              .widgetWithText(LoadingButton, tr('cancel'))
              .evaluate()
              .toList()
              .length,
          1);
      await scroll(
          tester, cancelOrderButtonFinder, orderDetailsScrollViewFinder);
      await tester.pump();
      expect(find.text(tr('reason_for_cancellation')), findsOneWidget);
      expect(find.text(tr('description')), findsOneWidget);
      expect(find.byType(CancelSheet), findsOneWidget);
      expect(find.byType(DescriptionTextfield), findsOneWidget);
      expect(tester.widgetList(find.byType(LoadingButton)).length, 2);
      expect(
          find
              .widgetWithText(LoadingButton, tr('apply'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(TextButton, tr('cancel'))
              .evaluate()
              .toList()
              .length,
          1);
      await tester.enterText(descriptionTextfieldFinder, 'test 1');
      await tester.tap(find.byKey(sheetApplyButtonKey));
      when(mockOrdersCubit.isOrderProcessing).thenReturn(false);
      await buildBody(tester, mockOrdersCubit, ordersList);
      expect(
          find
              .widgetWithText(LoadingButton, tr('cancel'))
              .evaluate()
              .toList()
              .length,
          0);
      mockOrdersCubit.orders.first.status = "delivered";
      await buildBody(tester, mockOrdersCubit, ordersList);
      expect(
          find
              .widgetWithText(LoadingButton, tr('buy_again'))
              .evaluate()
              .toList()
              .length,
          1);
      expect(
          find
              .widgetWithText(LoadingButton, tr('complain_order'))
              .evaluate()
              .toList()
              .length,
          1);
    });
  });
}

Future<void> buildBody(WidgetTester tester, MockOrdersCubit mockOrdersCubit,
    List<OrderModel> ordersList) async {
  await tester.pumpWidget(BlocProvider<OrdersCubit>(
    create: (BuildContext context) => mockOrdersCubit,
    child: MaterialApp(
      onGenerateRoute: (RouteSettings settings) => AppRouter.router(settings),
      navigatorKey: globalKey,
      home: Scaffold(
          body: OrderDetailsBody(
        state: mockOrdersCubit.state,
        order: ordersList.first,
        cancelReasonKey: GlobalKey<FormState>(),
        complainKey: GlobalKey<FormState>(),
        orderController: mockOrdersCubit,
      )),
    ),
  ));
}
