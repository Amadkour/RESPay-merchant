import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/api/remote_order_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/complain_order_inputs.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/model/order_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/orders/provider/repo/orders_repo.dart';

import '../../orders_value.dart';
import 'remote_order_repo_test.mocks.dart';


@GenerateMocks(<Type>[RemoteOrdersApi])
void main() {
   late MockRemoteOrdersApi mockRemoteOrdersApi;

  late OrdersRepo ordersRepo;

  setUpAll(() {
    mockRemoteOrdersApi = MockRemoteOrdersApi();
    ordersRepo = OrdersRepo(mockRemoteOrdersApi);
  });

  group('get Orders test', () {
    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: getOrderValues.successfulResponse,
              statusCode: 200,
              requestOptions: RequestOptions(path: getOrderValues.path)));

      when(mockRemoteOrdersApi.getOrders())
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await ordersRepo.get(),
          isA<Right<Failure, ParentModel>>());
    });

    test('get all celebrities test fail', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: getOrderValues.failureResponse,
              statusCode: 404,
              requestOptions: RequestOptions(path: getOrderValues.path)));

      when(mockRemoteOrdersApi.getOrders())
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await ordersRepo.get(),
          isA<Left<Failure, ParentModel>>());
    });
  });

  group('buy again test', () {
     test('test on success', () async {
       final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
           Response<Map<String, dynamic>>(
               data: buyAgainValues.successfulResponse,
               statusCode: 200,
               requestOptions: RequestOptions(path: buyAgainValues.path)));

       when(mockRemoteOrdersApi.buyAgain("dwed324434234"))
           .thenAnswer((Invocation realInvocation) async => response);
       expect(await ordersRepo.buyAgain("dwed324434234"),
           isA<Right<Failure, ParentModel>>());
     });

     test('get all celebrities test fail', () async {
       final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
           Response<Map<String, dynamic>>(
               data: buyAgainValues.failureResponse,
               statusCode: 404,
               requestOptions: RequestOptions(path: buyAgainValues.path)));

       when(mockRemoteOrdersApi.buyAgain("cadse2343234234"))
           .thenAnswer((Invocation realInvocation) async => response);
       expect(await ordersRepo.buyAgain("cadse2343234234"),
           isA<Left<Failure, ParentModel>>());
     });
   });

  group('track Order test', () {
     test('test on success', () async {
       final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
           Response<Map<String, dynamic>>(
               data: trackOrderValues.successfulResponse,
               statusCode: 200,
               requestOptions: RequestOptions(path: trackOrderValues.path)));

       when(mockRemoteOrdersApi.trackOrder("333ggg43453453434"))
           .thenAnswer((Invocation realInvocation) async => response);
       expect(await ordersRepo.trackOrder("333ggg43453453434"),
           isA<Right<Failure, OrderModel>>());
     });

     test('test on fail', () async {
       final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
           Response<Map<String, dynamic>>(
               data: trackOrderValues.failureResponse,
               statusCode: 404,
               requestOptions: RequestOptions(path: trackOrderValues.path)));

       when(mockRemoteOrdersApi.trackOrder("fsdf2334234234"))
           .thenAnswer((Invocation realInvocation) async => response);
       expect(await ordersRepo.trackOrder("fsdf2334234234"),
           isA<Left<Failure, OrderModel>>());
     });
   });

  group('cancel Order test', () {
     test('test on success', () async {

       when(mockRemoteOrdersApi.cancelOrder(description: "asdasdasd3324234",orderUUID: "test")).thenAnswer((Invocation realInvocation) async {
         return none();
       });

       expect(await ordersRepo.cancel(description: "test", orderUUID: "asdasdasd3324234"),
           isA<Some<dynamic>>());
     });
     test('test on fail', () async {

       when(mockRemoteOrdersApi.cancelOrder(description: "asdasdasd33",orderUUID: "test")).thenAnswer((Invocation realInvocation) async {
         return some(ApiFailure(
           errors: <String, dynamic>{},
         ));
       });

       expect(await ordersRepo.cancel(description: "test", orderUUID: "asdasdasd33"),
           isA<Some<dynamic>>());
     });
   });

  group('complain Order test', () {
     test('test on success', () async {

       when(mockRemoteOrdersApi.complainOrder(ComplainOrderInput(
         orderUUID: "",
         description: "",
         images: <String>[],
         reasonType: ""
       ))).thenAnswer((Invocation realInvocation) async {
         return none();
       });

       expect(await ordersRepo.cancel(description: "test", orderUUID: "asdasdasd3324234"),
           isA<Some<dynamic>>());
     });
     test('test on fail', () async {

       when(mockRemoteOrdersApi.complainOrder(ComplainOrderInput(
           orderUUID: "",
           description: "",
           images: <String>[],
           reasonType: ""
       ))).thenAnswer((Invocation realInvocation) async {
         return some(ApiFailure(
           errors: <String, dynamic>{},
         ));
       });
       expect(await ordersRepo.complain(ComplainOrderInput(
           orderUUID: "",
           description: "",
           images: <String>[],
           reasonType: ""
       )),isA<Some<dynamic>>());
     });
   });
}
