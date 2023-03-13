import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/provider/api/shop_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/shop/provider/module/shop_model.dart';

class ShopRepo {
  ShopModel data = ShopModel();

  Future<Either<Failure, ParentModel>> getShops() async {
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse =
        await ShopApi.instance.getShops();
    final ParentRepo<ShopModel> parentRepo = ParentRepo<ShopModel>(apiResponse, ShopModel());
    data = parentRepo.modelInstance as ShopModel;
    return parentRepo.getRepoResponseAsFailureAndModel();
  }
}
