// ignore_for_file: avoid_dynamic_calls
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:res_pay_merchant/core/errors/exceptions.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/providers/apis/more/local_more_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/providers/models/item_model.dart';

class MoreRepo {
  final MoreLocalApi _api;

  MoreRepo(this._api);

  Future<Either<Failure, List<ItemModel>>> getAccountItems() async {
    try {
      final String response = await _api.getAccountItems();
      final List<dynamic> options = json.decode(response) as List<dynamic>;
      return right(options
          .map((dynamic e) => ItemModel(
                imageUrl: e['imageUrl'] != null ? e['imageUrl'] as String : null,
                text: e['text'] != null ? e['text'] as String : null,
                navigateTo: e['navigateTo'] != null ? e['navigateTo'] as String : null,
                haveRightNumber: e['haveRightNumber'] != null ? e['haveRightNumber'] as bool : null,
                bottomSheetTitle:
                    e['bottom_sheet_title'] != null ? e['bottom_sheet_title'] as String : null,
                hasBottomSheet: e['hasBottomSheet'] != null ? e['hasBottomSheet'] as bool : null,
              ))
          .toList());
    } on NoInternetException {
      return left(
        NetworkFailure(),
      );
    } on ServerException catch (e) {
      return left(ApiFailure(
          code: e.statusCode,
          errors: e.errors,
          resourceName: "more repo line 18"));
    }
  }

  Future<Either<Failure, List<ItemModel>>> getHelpList() async {
    try {
      final String response = await _api.getHelpItems();
      final List<dynamic> options = json.decode(response) as List<dynamic>;
      return right(options
          .map((dynamic e) => ItemModel(
              imageUrl: e["imageUrl"] as String,
              text: e["text"] as String,
              navigateTo: e['navigateTo'] != null ? e['navigateTo'] as String : null,
              bottomSheetTitle:
                  e['bottom_sheet_title'] != null ? e['bottom_sheet_title'] as String : null))
          .toList());
    } on NoInternetException {
      return left(
        NetworkFailure(
            // message: e.toString()
        ),
      );
    } on ServerException catch (e) {
      return left(ApiFailure(
          code: e.statusCode,
          errors: e.errors,
          resourceName: "more repo line 18"));
    }
  }

  Future<Either<Failure, List<ItemModel>>> getSettingsList() async {
    try {
      final String response = await _api.getSettingsItems();
      final List<dynamic> options = json.decode(response) as List<dynamic>;
      return right(options
          .map(
            (dynamic e) => ItemModel(
              imageUrl: e["imageUrl"] as String,
              text: e["text"] as String,
              navigateTo: e['navigateTo'] != null ? e['navigateTo'] as String : null,
              haveSwitch: e['haveSwitch'] != null ? e['haveSwitch'] as bool : null,
            ),
          )
          .toList());
    } on NoInternetException {
      return left(
        NetworkFailure(),
      );
    } on ServerException catch (e) {
      return left(ApiFailure(
          code: e.statusCode,
          errors: e.errors,
          resourceName: "more repo line 18"));
    }
  }

  Future<Either<Failure, List<ItemModel>>> getUpperList() async {
    try {
      final String response = await _api.getUpperListItems();
      final List<dynamic> options = json.decode(response) as List<dynamic>;
      return right(options
          .map((dynamic e) => ItemModel(
                imageUrl: e["imageUrl"] as String,
                text: e["text"] as String,
                color: e['color'] as String,
                navigateTo: e['navigateTo'] as String,
              ))
          .toList());
    } on NoInternetException {
      return left(
        NetworkFailure(),
      );
    } on ServerException catch (e) {
      return left(ApiFailure(
          code: e.statusCode,
          errors: e.errors,
          resourceName: "more repo line 18"));
    }
  }
}
