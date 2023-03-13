import 'package:dartz/dartz.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/e_commerce/provider/models/product_model.dart';

abstract class StoreDetailRepo {
  Future<List<ParentModel>> getOffers();
  Future<List<ProductModel>> getHotDeals();
  Future<Either<Failure, ParentModel>> getSingleShop(String slug);
}
