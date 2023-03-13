import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/create_budget_category_input.dart';

abstract class BaseBudgetApi {
  Future<Either<Failure, Response<Map<String, dynamic>>>> getCategories(
      {String? period});
  Future<Either<Failure, Response<Map<String, dynamic>>>> create(
      CreateBudgetCategoryInput input);
  Future<Either<Failure, Response<Map<String, dynamic>>>> update(
      CreateBudgetCategoryInput input);
  Future<Option<Failure>> delete(String uuid);

  Future<Option<Failure>> changeStatus(String uuid);
}
