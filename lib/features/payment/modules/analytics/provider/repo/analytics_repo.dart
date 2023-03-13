import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/provider/api/base_analytics_api.dart';
import 'package:res_pay_merchant/features/payment/modules/analytics/provider/model/analytics_list_model.dart';

class AnalyticsRepo {
  final BaseAnalyticsApi _api;

  AnalyticsRepo(this._api);

  Future<Either<Failure, ParentModel>> getCategories() async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          await _api.get();
      final ParentRepo<AnalyticsListModel> parentRepo =
          ParentRepo<AnalyticsListModel>(response, AnalyticsListModel());
      return parentRepo.getRepoResponseAsFailureAndModel();
    } catch (e) {
      return left(GeneralFailure(
        errors: <String, String>{'': e.toString()},
      ));
    }
  }
}
