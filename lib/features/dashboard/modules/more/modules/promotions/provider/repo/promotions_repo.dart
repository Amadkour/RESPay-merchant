import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/promotions/provider/api/promotions_api.dart';
import 'package:res_pay_merchant/features/e_commerce/modules/cart/provider/models/promotions_model.dart';


class PromotionsRepo {
  final PromotionsApi _api;
  PromotionsRepo(this._api);
  Future<Either<Failure, ParentModel>> getPromotions() async {
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse =
    await _api.getPromotions();

    final ParentRepo<PromotionsModel> parentRepo = ParentRepo<PromotionsModel>(apiResponse, PromotionsModel());

    return parentRepo.getRepoResponseAsFailureAndModel();
  }
}
