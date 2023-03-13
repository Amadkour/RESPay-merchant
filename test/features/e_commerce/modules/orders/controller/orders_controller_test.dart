import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/cart_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/controller/orders_cubit.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_item_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_list_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/repo/orders_repo.dart';

import 'orders_controller_test.mocks.dart';

@GenerateMocks(<Type>[
  OrdersRepo
])
void main() {
  late MockOrdersRepo mockOrdersRepo;
  setUpAll(() {
    mockOrdersRepo = MockOrdersRepo();
  });
  final OrderModel orderModel = OrderModel(uuid: "sadad34243", addressUuid: 'sadad34243', paymentMethodUuid: 'paymentMethodUuidForTest',
    products: <OrderItemModel>[OrderItemModel(productUUid: '3234366dfgfdf545', uuid: 'dfdsff324234',title: "test product",quantity: 2,price: 100,thumbImage: "test image")],
    subTotal: 1, taxes: 2, shipping: 2, discount: 2, total: 100, orderNumber: 'ssad34234990',
  );
  group('test group Orders cubit', () {
    blocTest<OrdersCubit, OrdersState>(
      'onFail Test get orders',
      build: () {
        when(mockOrdersRepo.get())
            .thenAnswer((Invocation realInvocation) async =>
            Left<Failure, ParentModel>(ApiFailure()));
        return OrdersCubit(mockOrdersRepo);
      },
      act: (OrdersCubit bloc) {
        bloc.getOrders();
      },
      expect: () => <TypeMatcher<OrdersState>>[
        isA<OrdersFailure>(),
      ],
    );

    blocTest<OrdersCubit, OrdersState>(
      'onSuccess Test get orders',
      build: () {
        when(mockOrdersRepo.get())
            .thenAnswer((Invocation realInvocation) async =>
            Right<Failure, ParentModel>(OrderListModel(orders: <OrderModel>[orderModel])));
        return OrdersCubit(mockOrdersRepo);
      },
      act: (OrdersCubit bloc) {
        bloc.getOrders();
      },
      expect: () => <TypeMatcher<OrdersState>>[
        isA<OrdersLoaded>(),
      ],
    );

    ///--------reset method testing------///
    blocTest<OrdersCubit, OrdersState>(
      'verify that search method return success',
      build: () => OrdersCubit(mockOrdersRepo),
      act: (OrdersCubit bloc) => bloc.search("test"),
      expect: () => <TypeMatcher<OrdersState>>[
        isA<OrdersSearched>(),
        isA<OrdersLoaded>()
      ],
    );

    blocTest<OrdersCubit, OrdersState>(
      'verify that onCancelReasonChanged method return success',
      build: () => OrdersCubit(mockOrdersRepo),
      act: (OrdersCubit bloc) => bloc.onCancelReasonChanged("test"),
      expect: () => <TypeMatcher<OrdersState>>[
        isA<OrdersLoaded>()
      ],
    );

    blocTest<OrdersCubit, OrdersState>(
      'verify that removeImages method return success',
      build: () => OrdersCubit(mockOrdersRepo),
      act: (OrdersCubit bloc) {
        bloc.complainFiles=<String>['',''];
        bloc.removeImages(0);
      },
      expect: () => <TypeMatcher<OrdersState>>[
        isA<OrderComplainImagePicked>(),
        isA<OrdersLoaded>()
      ],
    );


    blocTest<OrdersCubit, OrdersState>(
      'onSuccess Test buyAgain',
      build: () {
        when(mockOrdersRepo.buyAgain("dasd2343243"))
            .thenAnswer((Invocation realInvocation) async =>
            Right<Failure, ParentModel>(CartModel()));
        return OrdersCubit(mockOrdersRepo);
      },
      act: (OrdersCubit bloc) {
        bloc.buyAgain("dasd2343243");
      },
      expect: () => <TypeMatcher<OrdersState>>[
        isA<OrderBoughtAgainLoading>(),
        isA<OrdersLoaded>(),
        isA<OrderBoughtAgainLoaded>(),
      ],
    );

    blocTest<OrdersCubit, OrdersState>(
      'onSuccess Test track',
      build: () {
        when(mockOrdersRepo.trackOrder("sadad34243"))
            .thenAnswer((Invocation realInvocation) async =>
            Right<Failure, OrderModel>(orderModel));
        return OrdersCubit(mockOrdersRepo);
      },
      act: (OrdersCubit bloc) {
        bloc.track(orderModel);
      },
      expect: () => <TypeMatcher<OrdersState>>[
        isA<SingleOrderLoading>(),
        isA<OrdersLoaded>(),
        isA<OrderTracked>(),
      ],
    );

    blocTest<OrdersCubit, OrdersState>(
      'onFail Test track',
      build: () {
        when(mockOrdersRepo.trackOrder("sadad34243"))
            .thenAnswer((Invocation realInvocation) async =>
            Left<Failure, OrderModel>(ApiFailure()));
        return OrdersCubit(mockOrdersRepo);
      },
      act: (OrdersCubit bloc) {
        bloc.track(orderModel);
      },
      expect: () => <TypeMatcher<OrdersState>>[
        isA<SingleOrderLoading>(),
        isA<OrdersLoaded>(),
        isA<SingleOrderFailure>(),
      ],
    );


    blocTest<OrdersCubit, OrdersState>(
      'onSuccess Test cancel',
      build: () {
        when(mockOrdersRepo.cancel(orderUUID: "sadad34243",description: "test description"))
            .thenAnswer((Invocation realInvocation) async =>  none());
        return OrdersCubit(mockOrdersRepo);
      },
      act: (OrdersCubit bloc) {

        bloc.order=orderModel;
        bloc.model =OrderListModel(orders: <OrderModel>[
          orderModel
        ]);
        bloc.cancelReason="test description";
        bloc.cancelOrder();
      },
      expect: () => <TypeMatcher<OrdersState>>[
        isA<SingleOrderLoading>(),
        isA<OrdersLoaded>(),
        isA<OrderCanceled>(),
      ],
    );
    blocTest<OrdersCubit, OrdersState>(
      'onFail Test cancel',
      build: () {
        when(mockOrdersRepo.cancel(orderUUID: "sadad34243",description: "test description"))
            .thenAnswer((Invocation realInvocation) async =>  some(ApiFailure()));
        return OrdersCubit(mockOrdersRepo);
      },
      act: (OrdersCubit bloc) {
        bloc.order=orderModel;
        bloc.model =OrderListModel(orders: <OrderModel>[orderModel]);
        bloc.cancelReason="test description";
        bloc.cancelOrder();
      },
      expect: () => <TypeMatcher<OrdersState>>[
        isA<SingleOrderLoading>(),
        isA<OrdersLoaded>(),
        isA<SingleOrderFailure>(),
      ],
    );
  });
}
