import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/api/cart_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/cart_model.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/valid_promo_code_model.dart';


class RemoteCartRepo {

  final CartApi _api;
  RemoteCartRepo(this._api);

  Future<Either<Failure, ParentModel>> getCartProducts(String shopUUID) async {
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse =
    await _api.getCartProducts(shopUUID);

    final ParentRepo<CartModel> parentRepo = ParentRepo<CartModel>(apiResponse, CartModel());

    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  Future<Either<Failure, ParentModel>> addProductToCart(String productUUID,String cartUUID) async{
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse =
        await _api.addProductToCart(productUUID,cartUUID);

    ///--------
    final ParentRepo<CartModel> parentRepo = ParentRepo<CartModel>(apiResponse, CartModel());

    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  Future<Either<Failure, ParentModel>> deleteProductFromCart(String itemKey,String cartUUID) async {
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse =
        await _api.deleteProductFromCart(itemKey,cartUUID);

    ///--------
    final ParentRepo<CartModel> parentRepo = ParentRepo<CartModel>(apiResponse, CartModel());

    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  Future<Either<Failure, ParentModel>> updateProductToCart(String itemKey, int quantity,String cartUUID) async {
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse =
    await _api.updateProductInCart(itemKey, quantity,cartUUID);

    final ParentRepo<CartModel> parentRepo = ParentRepo<CartModel>(apiResponse, CartModel());

    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  ////////////////////// promotions /////////////////////////////

  Future<Either<Failure, ParentModel>> removePromotions({required String promoCode}) async {
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse =
    await _api.removePromotion(promoCode);

    ///--------
    final ParentRepo<ValidPromoCodeModel> parentRepo = ParentRepo<ValidPromoCodeModel>(apiResponse, ValidPromoCodeModel());

    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  Future<Either<Failure, ParentModel>> checkPromotions({required String promoCode}) async {
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse =
    await _api.checkPromotion(promoCode);

    ///--------
    final ParentRepo<ValidPromoCodeModel> parentRepo = ParentRepo<ValidPromoCodeModel>(apiResponse, ValidPromoCodeModel());

    return parentRepo.getRepoResponseAsFailureAndModel();
  }

}
