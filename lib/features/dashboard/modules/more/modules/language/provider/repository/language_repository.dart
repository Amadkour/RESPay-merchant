import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/provider/API/language_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/provider/model/language_model.dart';

class LanguageRepository {
  LanguageModel data = LanguageModel();
  late LanguageAPI _languageAPI;

  LanguageRepository({LanguageAPI? languageAPI}) {
    _languageAPI = languageAPI ?? LanguageAPI.instance;
  }

  Future<Either<Failure, List<LanguageModel>>> getLanguagesRepository() async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res = await _languageAPI.getLanguages();
      return res.fold((Failure l) => Left<Failure, List<LanguageModel>>(l), (Response<Map<String, dynamic>> response) {
        if (response.statusCode != 200 || !(response.data!['success'] as bool)) {
          return Left<Failure, List<LanguageModel>>(ApiFailure(
              code: response.statusCode,
              resourceName: 'get_languages_line_27',
              errors: (response.data!['errors'] as Map<String, dynamic>?) ?? <String, String>{}));
        } else {
          return Right<Failure, List<LanguageModel>>(
              ((response.data!['data'] as Map<String, dynamic>)['locales'] as List<dynamic>)
                  .map((dynamic e) => LanguageModel.fromJson(e as Map<String, dynamic>))
                  .toList());
        }
      });
    } on Exception catch (e) {
      return Left<Failure, List<LanguageModel>>(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'get_language_repository_line_42',
      ));
    }
  }

  Future<Either<Failure, Map<String, dynamic>>> setLanguageRepository({
    required String apiLang,
  }) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res = await _languageAPI.setLanguage(locale: apiLang);
      return res.fold((Failure l) => Left<Failure, Map<String, dynamic>>(l),
          (Response<Map<String, dynamic>> response) async {
        if (response.statusCode != 200 || !(response.data!['success'] as bool)) {
          return Left<Failure, Map<String, dynamic>>(ApiFailure(
              code: response.statusCode,
              resourceName: 'set_language_repository_line_62',
              errors: (response.data!['errors'] as Map<String, dynamic>?) ?? <String, String>{}));
        } else {
          return Right<Failure, Map<String, dynamic>>(response.data!);
        }
      });
    } on Exception catch (e) {
      return Left<Failure, Map<String, dynamic>>(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'set_language_repository_line_76',
      ));
    }
  }
}
