import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/api/favourite_api.dart';

import '../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../../core/utilis.dart';
import '../../favourite_values.dart';

void main(){
  late MockDio mockedDio;
  late FavouriteApi api;

  setUpAll(() {
    mockedDio = MockDio();
    api = FavouriteApi.withDio(dio: mockedDio);
  });
  group("getFavouriteProducts", () {
    test('getFavouriteProducts Test', () async {
      when(mockedDio.get(getFavouritesValues.path)).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: getFavouritesValues.successfulResponse,
          requestOptions: RequestOptions(
            path: getFavouritesValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getFavouriteProducts();
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('getFavouriteProducts Failed Test', () async {
      when(mockedDio.post(getFavouritesValues.path)).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: getFavouritesValues.failureResponse,
          requestOptions: RequestOptions(
            path: getFavouritesValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getFavouriteProducts();
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  group("addToFavouriteProducts", () {
    test('addToFavouriteProducts Test', () async {
      when(mockedDio.post(addToFavouritesValues.path,data: compare(addToFavouritesValues.successfulBody!))).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: addToFavouritesValues.successfulResponse,
          requestOptions: RequestOptions(
            path: addToFavouritesValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.addProductToFavourite("85d59540-bbd4-32b8-b4b2-dd969e6a0fd3");
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('addToFavouriteProducts Failed Test', () async {
      when(mockedDio.post(addToFavouritesValues.path,data: compare(addToFavouritesValues.failureBody!))).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: addToFavouritesValues.failureResponse,
          requestOptions: RequestOptions(
            path: addToFavouritesValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.addProductToFavourite("22d59540-bbd4-32b8-b4b2-11969e6a0fd3");
      expect(result, isA<Left<Failure, Response<Map<String, dynamic>>>>());
    });
  });

  group("removeFromFavouriteProducts", () {
    test('removeFromFavouriteProducts Test', () async {
      when(mockedDio.post(removeFromFavouritesValues.path,data: compare(removeFromFavouritesValues.successfulBody!))).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: removeFromFavouritesValues.successfulResponse,
          requestOptions: RequestOptions(
            path: removeFromFavouritesValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.deleteProductFromFavourite(
          favouriteUUID: "d2c679a3-1289-4607-9f4d-266b51db0b97",
          productUUID: "85d59540-bbd4-32b8-b4b2-dd969e6a0fd3");
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('removeFromFavouriteProducts Failed Test', () async {
      when(mockedDio.post(removeFromFavouritesValues.path,data: compare(removeFromFavouritesValues.failureBody!))).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: removeFromFavouritesValues.failureResponse,
          requestOptions: RequestOptions(
            path: removeFromFavouritesValues.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.deleteProductFromFavourite(
          favouriteUUID: "d2c679a3-1289-4607-9f4d-266b51db0b97",
          productUUID: "22d59540-bbd4-32b8-b4b2-11969e6a0fd3");
      expect(result, isA<Left<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
