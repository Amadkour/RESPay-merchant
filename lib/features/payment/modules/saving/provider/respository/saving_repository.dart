import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/API/saving_api.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/model/role_model.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/model/saving_model.dart';

class SavingRepository {
  SavingRepository._singleTone();

  static final SavingRepository _instance = SavingRepository._singleTone();

  static SavingRepository get instance => _instance;

  Future<List<RoleModel>> getRoles() async {
    final String response =
        await rootBundle.loadString('assets/jsons/saving/roles.json');
    final List<Map<String, dynamic>> data =
        await json.decode(response) as List<Map<String, dynamic>>;
    return data
        .map((dynamic e) => RoleModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // Future<List<TransactionGlobalModel>> getSavingTransactionModels() async {
  //   final String response = await rootBundle.loadString('assets/jsons/saving/recent_activity.json');
  //   final List<Map<String, dynamic>> data = await json.decode(response) as List<Map<String, dynamic>>;
  //   return data.map((dynamic e) => TransactionGlobalModel.fromJson(e as Map<String, dynamic>)).toList();
  // }

  SavingModel data = SavingModel();

  /// Get Saving, transactions and roles
  Future<Either<Failure, ParentModel>> getSavingModelsRepository() async {
    final Either<Failure, Response<Map<String, dynamic>>> apiResponse =
        await SavingAPI.instance.getSavings();

    ///--------
    final ParentRepo<SavingModel> parentRepo = ParentRepo<SavingModel>(
        apiResponse, SavingModel(),
        innerMapName: 'savings');
    parentRepo.getRepoResponseAsFailureAndModel();
    data = parentRepo.modelInstance as SavingModel;
    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  /// Deposit
  Future<Either<Failure, Map<String, dynamic>>> addMoneyRepository(
      double amount) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await SavingAPI.instance.addMoney(amount: amount);
      return res.fold((Failure l) => Left<Failure, Map<String, dynamic>>(l),
          (Response<Map<String, dynamic>> response) {
        if (response.statusCode != 200 ||
            !(response.data!['success'] as bool)) {
          return Left<Failure, Map<String, dynamic>>(ApiFailure(
              code: response.statusCode,
              resourceName: 'add_money_saving_repository_line_87',
              errors: (response.data!['errors'] as Map<String, dynamic>?) ??
                  <String, String>{}));
        } else {
          return Right<Failure, Map<String, dynamic>>(response.data!);
        }
      });
    } on Exception catch (e) {
      return Left<Failure, Map<String, dynamic>>(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'CreateNewPassword_repository_line_37',
      ));
    }
  }

  /// Withdraw
  Future<Either<Failure, Map<String, dynamic>>> withdraw(double amount) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await SavingAPI.instance.withdraw(amount: amount);
      return res.fold((Failure l) => Left<Failure, Map<String, dynamic>>(l),
          (Response<Map<String, dynamic>> response) {
        if (response.statusCode != 200 ||
            !(response.data!['success'] as bool)) {
          return Left<Failure, Map<String, dynamic>>(ApiFailure(
              code: response.statusCode,
              resourceName: 'withdraw_saving_repository_line_117',
              errors: (response.data!['errors'] as Map<String, dynamic>?) ??
                  <String, String>{}));
        } else {
          return Right<Failure, Map<String, dynamic>>(response.data!);
        }
      });
    } on Exception catch (e) {
      return Left<Failure, Map<String, dynamic>>(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'CreateNewPassword_repository_line_37',
      ));
    }
  }

  /// Toggle Saving Repo
  Future<Either<Failure, Map<String, dynamic>>> toggleSavingRepository() async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await SavingAPI.instance.toggleSaving(loggedInUser.uuid ?? "");
      return res.fold((Failure l) => Left<Failure, Map<String, dynamic>>(l),
          (Response<Map<String, dynamic>> response) {
        if (response.statusCode != 200 ||
            !(response.data!['success'] as bool)) {
          return Left<Failure, Map<String, dynamic>>(ApiFailure(
              code: response.statusCode,
              resourceName: 'toggle_saving_repository_line_145',
              errors: (response.data!['errors'] as Map<String, dynamic>?) ??
                  <String, String>{}));
        } else {
          return Right<Failure, Map<String, dynamic>>(response.data!);
        }
      });
    } on Exception catch (e) {
      return Left<Failure, Map<String, dynamic>>(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'CreateNewPassword_repository_line_37',
      ));
    }
  }
}
