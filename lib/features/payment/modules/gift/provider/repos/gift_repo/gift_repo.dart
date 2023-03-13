import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/provider/api/gift_remote_api.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/provider/model/received_gift_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/created_beneficiary.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

class GiftRepository {
  final GiftRemoteApi _api;

  GiftRepository(this._api);

  Future<Either<Failure, ReceiptModel>> sendGift(
      {required Map<String, dynamic> input}) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await _api.sendGift(input: input);
      return res.fold((Failure l) => left(l),
          (Response<Map<String, dynamic>> r) {
        return right(ReceiptModel.fromJson(
            r.data!['data'] as Map<String, dynamic>, 'transfer'));
      });
    } catch (e) {
      return left(ApiFailure(
          errors: <String, String>{"": "Error when trying to send gift"}));
    }
  }

  Future<Either<Failure, ParentModel>> addNewGiftBeneficiary(
      {required Map<String, dynamic> input}) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await _api.addNewGiftBeneficiary(input: input);
      final ParentRepo<CreatedBeneficiaryModel> parentRepo =
          ParentRepo<CreatedBeneficiaryModel>(res, CreatedBeneficiaryModel());
      return parentRepo.getRepoResponseAsFailureAndModel();
    } catch (e) {
      return Left<Failure, ParentModel>(ApiFailure(errors: <String, String>{
        "": "Error when trying to add new gift beneficiary"
      }));
    }
  }

  /// Reset password Repository
  Future<Either<Failure, TodayGifts>> receiveGiftsRepository() async {
    try {
      /// --------------------------- Calling API Function ------------------------ ///
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await _api.getReceivedGifts();
      return res.fold((Failure l) => Left<Failure, TodayGifts>(l),
          (Response<Map<String, dynamic>> response) {
        if (response.statusCode != 200 ||
            !(response.data!['success'] as bool)) {
          /// Fail (Failure response)
          return Left<Failure, TodayGifts>(ApiFailure(
              code: response.statusCode,
              resourceName: 'receiveGiftsRepository_line_70',
              errors: (response.data!['errors'] as Map<String, dynamic>?) ??
                  <String, String>{}));
        } else {
          /// Success (Successful Repository Operation)
          ///
          return Right<Failure, TodayGifts>(TodayGifts.fromMap(
              response.data!['data'] as Map<String, dynamic>));
        }
      });
    } on Exception catch (e) {
      return Left<Failure, TodayGifts>(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'receiveGiftsRepository_line_61',
      ));
    }
  }
}
