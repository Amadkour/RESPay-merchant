import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/api/base_budget_api.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/create_budget_category_input.dart';

class JsonBudgetApi extends BaseBudgetApi {
  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> getCategories(
      {String? period}) async {
    // final String response = await rootBundle.loadString('assets/jsons/budget/budget_category.json');

    // return jsonDecode(response) as Map<String, dynamic>;
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> create(
      CreateBudgetCategoryInput input) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<Option<Failure>> delete(String uuid) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Response<Map<String, dynamic>>>> update(
      CreateBudgetCategoryInput input) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Option<Failure>> changeStatus(String uuid) {
    // TODO: implement changeStatus
    throw UnimplementedError();
  }
}
