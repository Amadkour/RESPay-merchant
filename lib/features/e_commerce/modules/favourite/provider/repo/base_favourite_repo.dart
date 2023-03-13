import 'package:dartz/dartz.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';

abstract class BaseFavouriteRepo {
  Future<Either<Failure, ParentModel>> addProductToFavorite(String productUUID);
  Future<Either<Failure, ParentModel>> deleteProductFromFavorite(
      String favouriteUUID, String productUUID);
  Future<Either<Failure, ParentModel>> getFavoriteProducts();
}
