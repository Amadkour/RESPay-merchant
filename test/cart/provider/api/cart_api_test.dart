import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/api/cart_api.dart';

import '../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../../core/utilis.dart';
import '../../cart_values.dart';


void main(){
  late MockDio mockedDio;
  late CartApi api;

  setUpAll(() {
    mockedDio = MockDio();
    api = CartApi.withDio(dio: mockedDio);
  });
  group("getCartProducts", () {
    test('getCartProducts Test', () async {
      when(mockedDio.get(getCartValues.path)).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: getCartValues.successfulResponse,
          requestOptions: RequestOptions(
            path: getCartValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getCartProducts("");
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('getCartProducts Failed Test', () async {
      when(mockedDio.post(getCartValues.path)).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: getCartValues.failureResponse,
          requestOptions: RequestOptions(
            path: getCartValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getCartProducts("");
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  group("addToCartProducts", () {
    test('addToCartProducts Test', () async {
      when(mockedDio.post(addToCartValues.path,data: compare(addToCartValues.successfulBody!))).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: addToCartValues.successfulResponse,
          requestOptions: RequestOptions(
            path: addToCartValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.addProductToCart("85d59540-777-32b8-b4b2-dd969e999fd1","");
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('addToCartProducts Failed Test', () async {
      when(mockedDio.post(addToCartValues.path,data: compare(addToCartValues.failureBody!))).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: addToCartValues.failureResponse,
          requestOptions: RequestOptions(
            path: addToCartValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.addProductToCart("22d59540-bbd4-32b8-b4b2-11969e6a0fd3","");
      expect(result, isA<Left<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  group("removeFromCartProducts", () {
    test('removeFromCartProducts Test', () async {
      when(mockedDio.post(removeFromCartValues.path,data: compare(removeFromCartValues.successfulBody!))).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: removeFromCartValues.successfulResponse,
          requestOptions: RequestOptions(
            path: removeFromCartValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.deleteProductFromCart("85d59540-7753-32b8-b4b2-dd939e6a0fd3","");
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('removeFromCartProducts Failed Test', () async {
      when(mockedDio.post(removeFromCartValues.path,data: compare(removeFromCartValues.failureBody!))).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: removeFromCartValues.failureResponse,
          requestOptions: RequestOptions(
            path: removeFromCartValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.deleteProductFromCart("85d59540-bbd4-32b8-b4b2-dd969e6a0fd3","");
      expect(result, isA<Left<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  group("updateProducts", () {
    test('updateProducts Test', () async {
      when(mockedDio.post(updateProductsInCartValues.path,data: compare(updateProductsInCartValues.successfulBody!))).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: updateProductsInCartValues.successfulResponse,
          requestOptions: RequestOptions(
            path: updateProductsInCartValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.updateProductInCart(
        "611e7be3-6187-4500-9c4d-75edb63ac2a1",
        2,""
      );
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('updateProducts Failed Test', () async {
      when(mockedDio.post(updateProductsInCartValues.path,data: compare(updateProductsInCartValues.failureBody!))).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: updateProductsInCartValues.failureResponse,
          requestOptions: RequestOptions(
            path: updateProductsInCartValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.updateProductInCart(
          "611e7be3-6187-4500-9c4d-75edb63ac2a2",
          2,""
      );
      expect(result, isA<Left<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  group("check Promotion", () {
    test('check Promotion Test', () async {
      when(mockedDio.post(checkPromotionCodeValues.path,data: compare(checkPromotionCodeValues.successfulBody!))).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: checkPromotionCodeValues.successfulResponse,
          requestOptions: RequestOptions(
            path: checkPromotionCodeValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.checkPromotion(
          "A56332434234h",
      );
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('check Promotion Failed Test', () async {
      when(mockedDio.post(checkPromotionCodeValues.path,data: compare(checkPromotionCodeValues.failureBody!))).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: checkPromotionCodeValues.failureResponse,
          requestOptions: RequestOptions(
            path: checkPromotionCodeValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.checkPromotion(
          "h56ww34434234a",
      );
      expect(result, isA<Left<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  group("remove Promotion", () {
    test('remove Promotion Test', () async {
      when(mockedDio.post(removePromotionCodeValues.path,data: compare(removePromotionCodeValues.successfulBody!))).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: removePromotionCodeValues.successfulResponse,
          requestOptions: RequestOptions(
            path: removePromotionCodeValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.removePromotion(
          "A56332434234h",
      );
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('remove Promotion Failed Test', () async {
      when(mockedDio.post(removePromotionCodeValues.path,data: compare(removePromotionCodeValues.failureBody!))).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: removePromotionCodeValues.failureResponse,
          requestOptions: RequestOptions(
            path: removePromotionCodeValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.removePromotion(
          "h56ww34434234a",
      );
      expect(result, isA<Left<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
