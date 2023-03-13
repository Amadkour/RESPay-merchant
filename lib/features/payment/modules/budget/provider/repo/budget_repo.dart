import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/api/base_budget_api.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/budget_category_model.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/budget_list_model.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/create_budget_category_input.dart';

class BudgetRepo {
  final BaseBudgetApi _api;

  BudgetRepo(this._api);

  Future<Either<Failure, ParentModel>> get({String? period}) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> result = await _api.getCategories(period: period);

      final ParentRepo<ParentModel> parentRepo = ParentRepo<BudgetListModel>(result, BudgetListModel());

      return parentRepo.getRepoResponseAsFailureAndModel();
    } catch (e) {
      return left(GeneralFailure( errors: <String,String>{'':e.toString()},));
    }
  }

  Future<Either<Failure, BudgetCategoryModel>> create(CreateBudgetCategoryInput input) async {
    return _processActionCallback(() => _api.create(input));
  }

  Future<Option<Failure>> delete(String uuid) async {
    try {
      final Option<Failure> result = await _api.delete(uuid);
      return result;
    } catch (e) {
      return some(GeneralFailure(errors: <String,String>{'':e.toString()},));
    }
  }

  Future<Either<Failure, BudgetCategoryModel>> update(CreateBudgetCategoryInput input) async {
    return _processActionCallback(() => _api.update(input));
  }

  Future<Either<Failure, BudgetCategoryModel>> _processActionCallback(
      Future<Either<Failure, Response<Map<String, dynamic>>>> Function() callback) async {
    try {
      final Either<Failure, Response<Map<String, dynamic>>> result = await callback();
      return result.fold((Failure l) => left(l), (Response<Map<String, dynamic>> r) {
        final Map<String, dynamic> data = (r.data!['data'] as Map<String, dynamic>)['budget'] as Map<String, dynamic>;
        return right(BudgetCategoryModel.fromMap(data));
      });
    } catch (e) {
      return left(GeneralFailure(errors: <String,String>{'':e.toString()},));
    }
  }

  Future<Option<Failure>> toggleCategory(String uuid) async {
    try {
      final Option<Failure> result = await _api.changeStatus(uuid);
      return result;
    } catch (e) {
      return some(GeneralFailure(errors: <String,String>{'':e.toString()},));
    }
  }
}
