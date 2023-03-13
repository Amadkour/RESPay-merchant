import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/provider/api/bill_api.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/provider/model/bill_summary.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/provider/model/bill_type_model.dart';

class BillRepo {
  Future<List<BillTypeModel>> getTypes() async {
    final String response = await rootBundle.loadString('assets/jsons/bill/bill_types.json');
    final List<dynamic> data = await json.decode(response) as List<dynamic>;
    return data.map((dynamic e) => BillTypeModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  ///---------------------------get supplies
  Future<Either<Failure, Map<String, dynamic>>> getSupplies() async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res =
          await BillApi.instance.getSuppliesList();

      return res.fold((Failure l) async => left<Failure, Map<String, String>>(l),
          (Response<Map<String, dynamic>> response) {
        final Map<String, dynamic> rightData =
            (response.data!['data'] as Map<String, dynamic>)['suppliers'] as Map<String, dynamic>;

        if (response.statusCode != 200 || !(response.data!['success'] as bool)) {
          return Left<Failure, Map<String, String>>(ApiFailure(
              code: response.statusCode,
              resourceName: 'suppliers_repository_line_44',
              errors: response.data!['errors'] != null
                  ? response.data!['errors'] as Map<String, dynamic>
                  : <String, dynamic>{}));
        } else {
          return Right<Failure, Map<String, dynamic>>(rightData);
        }
      });
    } on Exception catch (e) {
      return Left<Failure, Map<String, dynamic>>(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'suppliers_repository_line_57',
      ));
    }
  }

  ///---------------------------pay bill
  Future<Either<Failure, ParentModel?>> payBill({
    String? supplierType,
    String? customerId,
    bool isCheck = false,
  }) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> res = await BillApi.instance.payBill(
        supplierType: supplierType,
        customerId: customerId,
        check: isCheck ? 1 : 0,
      );
      return res.fold((Failure l) => left(l), (Response<Map<String, dynamic>> response) {
        if (response.statusCode != 200 || !(response.data!['success'] as bool)) {
          return left(ApiFailure(
              code: response.statusCode,
              resourceName: 'pay_bill_repository_line_55',
              errors: (response.data!['errors'] ?? <dynamic>{}) as Map<String, dynamic>));
        } else {
          if (isCheck) {
            final ParentRepo<BillSummaryModel> parentRepo =
                ParentRepo<BillSummaryModel>(res, BillSummaryModel());
            return parentRepo.getRepoResponseAsFailureAndModel();
          } else {
            return right(null);
          }
        }
      });
    } on Exception catch (e) {
      return left(ApiFailure(
        errors: <String, String>{'': e.toString()},
        code: 404,
        resourceName: 'pay_bill_repository_line_118',
      ));
    }
  }
}
