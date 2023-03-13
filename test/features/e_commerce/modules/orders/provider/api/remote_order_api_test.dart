import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/api/remote_order_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/end_point.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/complain_order_inputs.dart';

import '../../../../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../../../../../core/utilis.dart';
import '../../orders_value.dart';

void main() {
  late MockDio dio;

  late RemoteOrdersApi api;

  setUpAll(() {
    dio = MockDio();
    api = RemoteOrdersApi(dio: dio);
  });

  group("order api testing ", () {
    test(
      "verify get orders api return proper response",
          () async {
        when(dio.get(getOrderValues.path)).thenAnswer((Invocation realInvocation) async {
          return Response<Map<String, dynamic>>(
              requestOptions: RequestOptions(
                path: getOrderValues.path,
              ),
              data: getOrderValues.successfulResponse);
        });

        final Either<Failure, Response<Map<String, dynamic>>> result = await api.getOrders();

        expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
      },
    );

    test(
      "verify get orders api fail",
          () async {
        when(dio.get(getOrderListApi)).thenAnswer((Invocation realInvocation) async {
          return Response<Map<String, dynamic>>(
              requestOptions: RequestOptions(
                path: getOrderValues.path,
              ),
              data: getOrderValues.failureResponse);
        });

        final Either<Failure, Response<Map<String, dynamic>>> result = await api.getOrders();

        expect(result, isA<Left<Failure, Response<Map<String, dynamic>>>>());
      },
    );
  });

  group("trackOrder api testing ", () {
    test(
      "verify get trackOrder api return proper response",
          () async {
        when(dio.post(trackOrderValues.path,data: compare(trackOrderValues.successfulBody!))).thenAnswer((Invocation realInvocation) async {
          return Response<Map<String, dynamic>>(
              requestOptions: RequestOptions(
                path: trackOrderValues.path,
              ),
              data: trackOrderValues.successfulResponse);
        });

        final Either<Failure, Response<Map<String, dynamic>>> result = await api.trackOrder("ff342343433");

        expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
      },
    );

    test(
      "verify trackOrder api fail",
          () async {
        when(dio.post(trackOrderValues.path,data: compare(trackOrderValues.failureBody!))).thenAnswer((Invocation realInvocation) async {
          return Response<Map<String, dynamic>>(
              requestOptions: RequestOptions(
                path: trackOrderValues.path,
              ),
              data: trackOrderValues.failureResponse);
        });

        final Either<Failure, Response<Map<String, dynamic>>> result = await api.trackOrder("ff34234343355555");

        expect(result, isA<Left<Failure, Response<Map<String, dynamic>>>>());
      },
    );
  });

  group("buy again api testing ", () {
    test(
      "verify buy again api return proper response",
          () async {
        when(dio.post(buyAgainValues.path,data: compare(buyAgainValues.successfulBody!))).thenAnswer((Invocation realInvocation) async {
          return Response<Map<String, dynamic>>(
              requestOptions: RequestOptions(
                path: buyAgainValues.path,
              ),
              data: buyAgainValues.successfulResponse);
        });

        final Either<Failure, Response<Map<String, dynamic>>> result = await api.buyAgain("552d7f8f-21bb-4acb-b2d8");

        expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
      },
    );

    test(
      "verify buy again api fail",
          () async {
        when(dio.post(buyAgainValues.path,data: compare(buyAgainValues.failureBody!))).thenAnswer((Invocation realInvocation) async {
          return Response<Map<String, dynamic>>(
              requestOptions: RequestOptions(
                path: buyAgainValues.path,
              ),
              data: buyAgainValues.failureResponse);
        });

        final Either<Failure, Response<Map<String, dynamic>>> result = await api.buyAgain("552d7f8f-21bb-4acb-b2d8-a1f504056dc6");

        expect(result, isA<Left<Failure, Response<Map<String, dynamic>>>>());
      },
    );
  });

  group("cancel order api testing ", () {
    test(
      "verify cancelOrder api return proper response",
          () async {
        when(dio.post(cancelOrderValues.path,data: compare(cancelOrderValues.successfulBody!))).thenAnswer((Invocation realInvocation) async {
          return Response<Map<String, dynamic>>(
              requestOptions: RequestOptions(
                path: cancelOrderValues.path,
              ),
              data: cancelOrderValues.successfulResponse);
        });

        final Option<Failure> result = await api.cancelOrder(orderUUID: "552d7f8f-21bb-4acb-b2d8-a1f504056dc6",description: "test ");

        expect(result, isA<None<dynamic>>());
      },
    );

    test(
      "verify cancelOrder api fail",
          () async {
        when(dio.post(cancelOrderValues.path,data: compare(cancelOrderValues.failureBody!))).thenAnswer((Invocation realInvocation) async {
          return Response<Map<String, dynamic>>(
              requestOptions: RequestOptions(
                path: cancelOrderValues.path,
              ),
              data: cancelOrderValues.failureResponse);
        });

        final Option<Failure> result = await api.cancelOrder(orderUUID: "552d7f8f-21bb-4a",description: "test");

        expect(result, isA<Some<Failure>>());
      },
    );
  });

  group("complain api testing ", () {
    test(
      "verify complain api return proper response",
          () async {
        when(dio.post(complainOrderValues.path,data: compare(complainOrderValues.successfulBody!))).thenAnswer((Invocation realInvocation) async {
          return Response<Map<String, dynamic>>(
              requestOptions: RequestOptions(
                path: complainOrderValues.path,
              ),
              data: complainOrderValues.successfulResponse);
        });

        final Option<Failure> result = await api.complainOrder(ComplainOrderInput(
            orderUUID: "orderUUID 1",
            reasonType: "test 1",
            description: "description 1",
            images: <String>[]
          )
        );
        expect(result, isA<None<dynamic>>());
      },
    );

    test(
      "verify cancelOrder api fail",
          () async {
        when(dio.post(complainOrderValues.path,data: compare(complainOrderValues.failureBody!))).thenAnswer((Invocation realInvocation) async {
          return Response<Map<String, dynamic>>(
              requestOptions: RequestOptions(
                path: complainOrderValues.path,
              ),
              data: complainOrderValues.failureResponse);
        });

        final Option<Failure> result = await api.complainOrder(ComplainOrderInput(
            orderUUID: "orderUUID 2",
            reasonType: "test 2",
            description: "description 1",
            images: <String>[]
          )
        );
        expect(result, isA<Some<Failure>>());
      },
    );
  });
}
