import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/api/favourite_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/models/favourite_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/models/favourite_product_added_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/models/favourite_product_removed_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/favourite/provider/repo/base_favourite_repo.dart';

class RemoteFavoriteRepo extends BaseFavouriteRepo {
  final FavouriteApi _api;
  RemoteFavoriteRepo(this._api);
  @override
  Future<Either<Failure, ParentModel>> addProductToFavorite(
      String productUUID) async {
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse =
        await _api.addProductToFavourite(productUUID);

    ///--------
    final ParentRepo<FavouriteProductAddedModel> parentRepo =
        ParentRepo<FavouriteProductAddedModel>(
            apiResponse, FavouriteProductAddedModel());

    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  @override
  Future<Either<Failure, ParentModel>> deleteProductFromFavorite(
      String favouriteUUID, String productUUID) async {
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse =
        await _api.deleteProductFromFavourite(
            productUUID: productUUID, favouriteUUID: favouriteUUID);

    ///--------
    final ParentRepo<FavouriteProductRemovedModel> parentRepo =
        ParentRepo<FavouriteProductRemovedModel>(
            apiResponse, FavouriteProductRemovedModel());

    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  @override
  Future<Either<Failure, ParentModel>> getFavoriteProducts() async {
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse =
        await _api.getFavouriteProducts();

    ///--------
    final ParentRepo<FavoritesModel> parentRepo =
        ParentRepo<FavoritesModel>(apiResponse, FavoritesModel());

    return parentRepo.getRepoResponseAsFailureAndModel();
  }
}
