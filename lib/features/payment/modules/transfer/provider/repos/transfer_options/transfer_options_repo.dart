import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/transfer_options/transfer_options_remote_api.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer_options_model.dart';

class TransferOptionsRepo {
  final TransferOptionsRemoteApi _api;

  TransferOptionsRepo(this._api);

  Future<Either<Failure, ParentModel>> get() async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          await _api.get();

      final ParentRepo<TransferOptionsModel> parentRepo =
          ParentRepo<TransferOptionsModel>(response, TransferOptionsModel());

      return parentRepo.getRepoResponseAsFailureAndModel();
    } catch (e) {
      return Left<Failure, ParentModel>(ApiFailure(errors: <String, String>{
        "": "Error when trying to get transfers options"
      }));
    }
  }
}
