import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/api/favourite_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/repo/remote_favourite_repo.dart';

import '../../favourite_values.dart';
import 'favourite_repo_test.mocks.dart';

@GenerateMocks(<Type>[FavouriteApi])
void main() {
  late MockFavouriteApi mockFavouriteApi;

  late RemoteFavoriteRepo remoteFavoriteRepo;

  setUpAll(() {
    mockFavouriteApi = MockFavouriteApi();
    remoteFavoriteRepo = RemoteFavoriteRepo(mockFavouriteApi);
  });

  group('get favourites test', () {
    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
                  data: getFavouritesValues.successfulResponse,
                  statusCode: 200,
                  requestOptions:
                      RequestOptions(path: getFavouritesValues.path)));

      when(mockFavouriteApi.getFavouriteProducts())
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await remoteFavoriteRepo.getFavoriteProducts(),
          isA<Right<Failure, ParentModel>>());
    });

    test('get favourites test fail', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
                  data: getFavouritesValues.failureResponse,
                  statusCode: 404,
                  requestOptions:
                      RequestOptions(path: getFavouritesValues.path)));

      when(mockFavouriteApi.getFavouriteProducts())
          .thenAnswer((Invocation realInvocation) async => response);
      expect(await remoteFavoriteRepo.getFavoriteProducts(),
          isA<Left<Failure, ParentModel>>());
    });
  });

  group('add to favourites test', () {
    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
                  data: addToFavouritesValues.successfulResponse,
                  statusCode: 200,
                  requestOptions:
                      RequestOptions(path: addToFavouritesValues.path)));

      when(mockFavouriteApi
              .addProductToFavourite("d2c679a3-1289-4607-9f4d-266b51db0b97"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(
          await remoteFavoriteRepo
              .addProductToFavorite("d2c679a3-1289-4607-9f4d-266b51db0b97"),
          isA<Right<Failure, ParentModel>>());
    });

    test('test on fail', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
                  data: addToFavouritesValues.failureResponse,
                  statusCode: 404,
                  requestOptions:
                      RequestOptions(path: addToFavouritesValues.path)));

      when(mockFavouriteApi
              .addProductToFavourite("d2c679a3-2222-8784-9f4d-266b51do0b97"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(
          await remoteFavoriteRepo
              .addProductToFavorite("d2c679a3-2222-8784-9f4d-266b51do0b97"),
          isA<Left<Failure, ParentModel>>());
    });
  });

  group('remove from favourites test', () {
    test('test on success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
                  data: removeFromFavouritesValues.successfulResponse,
                  statusCode: 200,
                  requestOptions:
                      RequestOptions(path: removeFromFavouritesValues.path)));

      when(mockFavouriteApi
              .addProductToFavourite("d2c679a3-1289-4607-9f4d-266b51db0b97"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(
          await remoteFavoriteRepo
              .addProductToFavorite("d2c679a3-1289-4607-9f4d-266b51db0b97"),
          isA<Right<Failure, ParentModel>>());
    });

    test('test on fail', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
                  data: removeFromFavouritesValues.failureResponse,
                  statusCode: 404,
                  requestOptions:
                      RequestOptions(path: removeFromFavouritesValues.path)));

      when(mockFavouriteApi
              .addProductToFavourite("d2c679a3-2222-8784-9f4d-266b51do0b97"))
          .thenAnswer((Invocation realInvocation) async => response);
      expect(
          await remoteFavoriteRepo
              .addProductToFavorite("d2c679a3-2222-8784-9f4d-266b51do0b97"),
          isA<Left<Failure, ParentModel>>());
    });
  });
}
