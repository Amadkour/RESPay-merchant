import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/api/customer_loyalty_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/models/customer_loyality_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/models/customer_loyalty_list_model.dart';

class CustomerLoyaltyRepo {
  final CustomerLoyaltyApi _api;

  CustomerLoyaltyRepo(this._api);

  Future<Either<Failure, ParentModel>> getLoyalties() async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> response = await _api.getLoyalties();

      final ParentRepo<CustomerLoyaltyListModel> parentRepo =
          ParentRepo<CustomerLoyaltyListModel>(response, CustomerLoyaltyListModel());
      return parentRepo.getRepoResponseAsFailureAndModel();
    } catch (e) {
      return left(
        GeneralFailure(
          errors: <String, String>{'': e.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, CustomerLoyaltyModel>> show(String uuid) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> response = await _api.show(uuid);

      return response.fold((Failure l) => left(l), (Response<Map<String, dynamic>> r) {
        final CustomerLoyaltyModel model = CustomerLoyaltyModel.fromJson(
            (r.data?['data'] as Map<String, dynamic>?)?['shops'] as Map<String, dynamic>);
        return right(model);
      });
    } catch (e) {
      return left(
        GeneralFailure(
          errors: <String, String>{'': e.toString()},
        ),
      );
    }
  }

  Future<Either<Failure, String>> redeem(String uuid) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> response = await _api.redeem(uuid);

      return response.fold((Failure l) => left(l), (Response<Map<String, dynamic>> r) {
        return right(r.data?['hint'] as String? ?? "");
      });
    } catch (e) {
      return left(
        GeneralFailure(
          errors: <String, String>{'': e.toString()},
        ),
      );
    }
  }
}
