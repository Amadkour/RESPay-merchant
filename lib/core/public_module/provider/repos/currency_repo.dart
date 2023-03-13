import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/provider/api/currency_base_api.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/country_list_model.dart';
import 'package:res_pay_merchant/core/public_module/provider/model/currency_list_model.dart';

import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';

class CurrencyRepository {
  final CurrencyBaseApi _api;

  CurrencyRepository(this._api);

  Future<Either<Failure, ParentModel>> getCurrencies() async {
    final Either<Failure, Response<Map<String, dynamic>>> json =
        await _api.getCurrencies();
    final ParentRepo<CurrencyListModel> parentRepo =
        ParentRepo<CurrencyListModel>(json, CurrencyListModel());
    return parentRepo.getRepoResponseAsFailureAndModel();
  }

  Future<Either<Failure, ParentModel>> getCountries() async {
    final Either<Failure, Response<Map<String, dynamic>>> json =
        await _api.getCountries();
    final ParentRepo<CountryListModel> parentRepo =
        ParentRepo<CountryListModel>(json, CountryListModel());
    return parentRepo.getRepoResponseAsFailureAndModel();
  }



}
