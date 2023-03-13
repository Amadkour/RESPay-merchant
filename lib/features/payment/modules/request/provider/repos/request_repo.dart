import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/api/request_remote_api.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/model/money_requests_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/created_beneficiary.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

class RequestRemoteRepo {
  final RequestRemoteApi _api;
  RequestRemoteRepo(this._api);

  Future<Either<Failure, ParentModel>> addNewRequestBeneficiary(
      {required Map<String, dynamic> input}) async {
    final Either<Failure, Response<Map<String, dynamic>>> res =
        await _api.addNewRequestBeneficiary(input: input);
    final ParentRepo<CreatedBeneficiaryModel> parentRepo =
        ParentRepo<CreatedBeneficiaryModel>(res, CreatedBeneficiaryModel());
    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  Future<Either<Failure, ParentModel>> getMoneyRequests() async {
    final Either<Failure, Response<Map<String, dynamic>>> res =
        await _api.getMoneyRequests();
    final ParentRepo<MoneyRequestsModel> parentRepo =
        ParentRepo<MoneyRequestsModel>(res, MoneyRequestsModel());
    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  Future<Either<Failure, ReceiptModel>> requestMoney(
      {required Map<String, dynamic> input}) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await _api.sendMoney(input: input);

      return res.fold((Failure l) => left(l),
          (Response<Map<String, dynamic>> r) {
        return right(ReceiptModel.fromJson(
            r.data!['data'] as Map<String, dynamic>, 'request'));
      });
    } catch (e) {
      return left(ApiFailure(
          errors: <String, String>{"": "Error when trying to request money"}));
    }
  }

  Future<Either<Failure, ParentModel>> acceptOrRejectRequest(
      {required Map<String, dynamic> input}) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await _api.acceptOrRejectRequest(input: input);

      final ParentRepo<MoneyRequestsModel> parentRepo =
          ParentRepo<MoneyRequestsModel>(res, MoneyRequestsModel());
      return parentRepo.getRepoResponseAsFailureAndModel();
    } catch (e) {
      return left(ApiFailure(errors: <String, String>{
        "": "Error when trying to get money requests"
      }));
    }
  }
}
