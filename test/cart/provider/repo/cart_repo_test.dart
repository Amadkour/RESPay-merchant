import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/api/cart_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/repo/remote_cart_repo.dart';

import '../../cart_values.dart';
import 'cart_repo_test.mocks.dart';

@GenerateMocks(<Type>[CartApi])
void main() {
  late MockCartApi mockCartApi;

  late RemoteCartRepo remoteCartRepo;

  setUpAll(() {
    mockCartApi = MockCartApi();
    remoteCartRepo = RemoteCartRepo(mockCartApi);
  });

  group('get cart test', () {
    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: getCartValues.successfulResponse,
              statusCode: 200,
              requestOptions: RequestOptions(path: getCartValues.path)));

      when(mockCartApi.getCartProducts("SHOPUUID"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await remoteCartRepo.getCartProducts(""),
          isA<Right<Failure, ParentModel>>());
    });

    test('get cart test fail', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: getCartValues.failureResponse,
              statusCode: 404,
              requestOptions: RequestOptions(path: getCartValues.path)));

      when(mockCartApi.getCartProducts("SHOPUUID"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await remoteCartRepo.getCartProducts(""),
          isA<Left<Failure, ParentModel>>());
    });
  });

  group('add to cart test', () {
    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: addToCartValues.successfulResponse,
              statusCode: 200,
              requestOptions: RequestOptions(path: addToCartValues.path)));

      when(mockCartApi.addProductToCart("d2c679a3-1289-4607-9f4d-266b51db0b97","TestCartUUid"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await remoteCartRepo.addProductToCart("d2c679a3-1289-4607-9f4d-266b51db0b97",""),
          isA<Right<Failure, ParentModel>>());
    });

    test('test on fail', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: addToCartValues.failureResponse,
              statusCode: 404,
              requestOptions: RequestOptions(path: addToCartValues.path)));

      when(mockCartApi.addProductToCart("d2c679a3-2222-8784-9f4d-266b51do0b97","TestCartUUid"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await remoteCartRepo.addProductToCart("d2c679a3-2222-8784-9f4d-266b51do0b97",""),
          isA<Left<Failure, ParentModel>>());
    });
  });

  group('remove from cart test', () {
    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: removeFromCartValues.successfulResponse,
              statusCode: 200,
              requestOptions: RequestOptions(path: removeFromCartValues.path)));

      when(mockCartApi.deleteProductFromCart("d2c679a3-1289-4607-9f4d-266b51db0b97","TestCartUUid"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await remoteCartRepo.deleteProductFromCart("d2c679a3-1289-4607-9f4d-266b51db0b97",""),
          isA<Right<Failure, ParentModel>>());
    });

    test('test on fail', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: removeFromCartValues.failureResponse,
              statusCode: 404,
              requestOptions: RequestOptions(path: removeFromCartValues.path)));

      when(mockCartApi.deleteProductFromCart("d2c679a3-2222-8784-9f4d-266b51do0b97","TestCartUUid"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await remoteCartRepo.deleteProductFromCart("d2c679a3-2222-8784-9f4d-266b51do0b97",""),
          isA<Left<Failure, ParentModel>>());
    });
  });

  group('update cart test', () {
    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: updateProductsInCartValues.successfulResponse,
              statusCode: 200,
              requestOptions: RequestOptions(path: updateProductsInCartValues.path)));

      when(mockCartApi.updateProductInCart("611e7be3-6187-4500-9c4d-75edb63ac2a1",2,"TestCartUUid"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await remoteCartRepo.updateProductToCart("611e7be3-6187-4500-9c4d-75edb63ac2a1",2,""),
          isA<Right<Failure, ParentModel>>());
    });

    test('test on fail', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: updateProductsInCartValues.failureResponse,
              statusCode: 404,
              requestOptions: RequestOptions(path: updateProductsInCartValues.path)));

      when(mockCartApi.updateProductInCart("611e7be3-6187-4500-9c4d-75edb63ac2a2",1,"TestCartUUid"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await remoteCartRepo.updateProductToCart("611e7be3-6187-4500-9c4d-75edb63ac2a2",1,""),
          isA<Left<Failure, ParentModel>>());
    });
  });

  group('remove promotions test', () {
    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: removePromotionCodeValues.successfulResponse,
              statusCode: 200,
              requestOptions: RequestOptions(path: removePromotionCodeValues.path)));

      when(mockCartApi.removePromotion("A56332434234h"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await remoteCartRepo.removePromotions(promoCode: "A56332434234h"),
          isA<Right<Failure, ParentModel>>());
    });

    test('test on fail', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response = Right<Failure, Response<Map<String, dynamic>>>(
          Response<Map<String, dynamic>>(
              data: removePromotionCodeValues.failureResponse,
              statusCode: 404,
              requestOptions: RequestOptions(path: removePromotionCodeValues.path)));

      when(mockCartApi.removePromotion("A56332434234h"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await remoteCartRepo.removePromotions(promoCode: "A56332434234h"),
          isA<Left<Failure, ParentModel>>());
    });
  });
}
