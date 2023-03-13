import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/api/beneficiary/beneficiary_remote_api.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/beneficary_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/created_beneficiary.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/favourite_toggle_model.dart';

class BeneficiaryRemoteRepo {
  final BeneficiaryRemoteApi _api;

  BeneficiaryRemoteRepo(this._api);
  Future<Either<Failure, ParentModel>> addNewTransferBeneficiary(
      {required Map<String, dynamic> inputs}) async {
    final Either<Failure, Response<Map<String, dynamic>>> res =
        await _api.createTransferBeneficiary(inputs: inputs);

    final ParentRepo<CreatedBeneficiaryModel> parentRepo =
        ParentRepo<CreatedBeneficiaryModel>(res, CreatedBeneficiaryModel());
    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  Future<Either<Failure, ParentModel>> getBeneficiary({String? method}) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await _api.getBeneficiaries(method: method);
      final ParentRepo<BeneficiariesModel> parentRepo =
          ParentRepo<BeneficiariesModel>(
        res,
        BeneficiariesModel(),
      );
      return parentRepo.getRepoResponseAsFailureAndModel();
    } catch (e) {
      return Left<Failure, ParentModel>(ApiFailure(errors: <String, String>{
        "": "Error when trying to get all transfers beneficiaries"
      }));
    }
  }

  Future<Either<Failure, ParentModel>> favouriteToggle(
      {String? beneficiaryUUiD}) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await _api.favouriteToggle(beneficiaryUUiD: beneficiaryUUiD);
      final ParentRepo<FavouriteToggleModel> parentRepo =
          ParentRepo<FavouriteToggleModel>(
        res,
        FavouriteToggleModel(),
      );
      return parentRepo.getRepoResponseAsFailureAndModel();
    } catch (e) {
      return Left<Failure, ParentModel>(ApiFailure(errors: <String, String>{
        "": "Error when trying to get toggle in favourite"
      }));
    }
  }


  Future<Either<Failure, List<BeneficiariesModel>>> deleteBeneficiry({required String uuid}) async {
    try {
      /// --------------------------- Calling API Function ------------------------ ///
      final Either<Failure, Response<dynamic>> res =
      await _api.deleteBeneficiery(uuid: uuid);

      return res.fold((Failure l) => Left<Failure, List<BeneficiariesModel>>(l),
              (Response<dynamic> response) {
            if (response.statusCode != 200 ||
                !((response.data as Map<String, dynamic>?)!['success'] as bool)) {
              /// Failure Response
              return Left<Failure, List<BeneficiariesModel>>(ApiFailure(
                  code: response.statusCode,
                  resourceName: 'Notification_repository_line_35',
                  errors: ((response.data as Map<String, dynamic>?)!['errors']
                  as Map<String, dynamic>?) ??
                      <String, String>{}));
            } else {
              /// Success
              return const Right<Failure, List<BeneficiariesModel>>(<BeneficiariesModel>[]);
            }
          });
    } on Exception catch (e) {
      /// Repository Crashed
      return Left<Failure, List<BeneficiariesModel>>(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'notification_repository_line_50',
      ));
    }
  }
}
