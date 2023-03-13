import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:res_pay_merchant/core/errors/exceptions.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';

import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/API/cards_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/transaction_global_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/provider/model/limits_model.dart';
import 'package:res_pay_merchant/features/payment/modules/add_card/api/model/create_card_input.dart';
import 'package:res_pay_merchant/features/payment/modules/add_card/api/model/payment_method.dart';

class CardsSectionRepository {
  late CardsAPI _api;

  CardsSectionRepository({CardsAPI? api}) {
    _api = api!;
  }
  CardsSectionRepository._singleTone() {
    _api = CardsAPI.instance;
  }

  static final CardsSectionRepository _instance =
      CardsSectionRepository._singleTone();

  static CardsSectionRepository get instance => _instance;

  Future<LimitsModel> getAllLimits() async {
    final String response =
        await rootBundle.loadString('assets/jsons/cards/limits.json');
    final Map<String, dynamic> data =
        await json.decode(response) as Map<String, dynamic>;
    return LimitsModel.fromJson(data);
  }

  Future<List<TransactionGlobalModel>> getAllTransactions() async {
    final String response =
        await rootBundle.loadString('assets/jsons/saving/recent_activity.json');
    final List<Map<String, dynamic>> data =
        (await json.decode(response) as List<dynamic>)
            .cast<Map<String, dynamic>>();
    return data
        .map((dynamic e) =>
            TransactionGlobalModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Either<Failure, List<CreditCardModel>>> getCardsRepository() async {
    try {
      final Map<String, dynamic> res = await _api.getCreditCards();

      final List<Map<String, dynamic>> list =
          (res['credit_cards'] as List<dynamic>).cast<Map<String, dynamic>>();

      return right(List<CreditCardModel>.from(
          list.map((Map<String, dynamic> e) => CreditCardModel.fromJson(e))));
    } on NoInternetException {
      return left(
        NetworkFailure(),
      );
    } on ServerException catch (e) {
      return left(ApiFailure(
          code: e.statusCode,
          errors: e.errors,
          resourceName: "deposit repo line 26"));
    }
  }

  Future<Either<Failure, List<PaymentMethod>>> getPaymentMethods() async {
    try {
      final Map<String, dynamic> result = await _api.getPaymentMethods();
      final List<Map<String, dynamic>> list =
          (result['payment_methods'] as List<dynamic>)
              .cast<Map<String, dynamic>>();
      return right(List<PaymentMethod>.from(
          list.map((Map<String, dynamic> e) => PaymentMethod.fromMap(e))));
    } on NoInternetException {
      return left(
        NetworkFailure(),
      );
    } on ServerException catch (e) {
      return left(ApiFailure(
          code: e.statusCode,
          errors: e.errors,
          resourceName: "deposit repo line 26"));
    }
  }

  Future<Option<Failure>> createCard(CreateCardInput input) async {
    try {
      await _api.createCard(input);

      return none();
    } on NoInternetException {
      return some(
        NetworkFailure(),
      );
    } on ServerException catch (e) {
      return some(ApiFailure(
        code: e.statusCode,
        errors: e.errors,
        resourceName: "deposit repo line 26",
      ));
    }
  }

  Future<Option<Failure>> deleteCard(String uuid) async {
    try {
      await _api.deleteCard(uuid);

      return none();
    } on NoInternetException {
      return some(
        NetworkFailure(
            // message: e.toString()
            ),
      );
    } on ServerException catch (e) {
      return some(ApiFailure(
          // errors: <String,String>{'':e.message},
          code: e.statusCode,
          errors: e.errors,
          resourceName: "deposit repo line 26"));
    }
  }
}
