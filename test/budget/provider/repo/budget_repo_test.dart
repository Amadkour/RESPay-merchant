// ignore_for_file: always_specify_types

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/api/remote_budget_api.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/budget_category_model.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/budget_list_model.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/repo/budget_repo.dart';

import '../budget_values.dart';
import 'budget_repo_test.mocks.dart';

@GenerateMocks([RemoteBudgetApi])
void main() {
  late MockRemoteBudgetApi budgetApi;
  late BudgetRepo repo;

  late Response<Map<String, dynamic>> response;
  late BudgetCategoryModel categoryModel;
  late ApiFailure failure;
  setUpAll(() {
    budgetApi = MockRemoteBudgetApi();
    repo = BudgetRepo(budgetApi);

    failure = ApiFailure();
    response = Response<Map<String, dynamic>>(
      statusCode: 200,
      data: getBudgetValues.successfulResponse,
      requestOptions: RequestOptions(
        path: getBudgetValues.path,
      ),
    );

    categoryModel = BudgetCategoryModel.fromMap(
      (updateBudgetCategoryValues.successfulResponse['data']
          as Map<String, dynamic>)['budget'] as Map<String, dynamic>,
    );
  });

  group("budget list testing", () {
    //------ load budget testing -----//

    test("verify that get budget api return response", () async {
      when(budgetApi.getCategories())
          .thenAnswer((Invocation realInvocation) async {
        return right(response);
      });

      final Either<Failure, ParentModel> result = await repo.get();
      final Object model = result.fold(
          (Failure l) => l, (ParentModel r) => r as BudgetListModel);
      expect(model, equals(budgetParentModel));
    });

    //------ load budget testing -----//

    test("verify that get budget api return failure", () async {
      when(budgetApi.getCategories())
          .thenThrow((Invocation realInvocation) async {
        return left(failure);
      });

      final Either<Failure, ParentModel> result = await repo.get();
      final Object model = result.fold((Failure l) => l, (ParentModel r) => r);
      expect(model, isA<GeneralFailure>());
    });

    test(
        "verify that get budget api return failure if any of map element is missing",
        () async {
      when(budgetApi.getCategories())
          .thenThrow((Invocation realInvocation) async {
        getBudgetSuccessResponse.remove('budgets');
        return right(Response<Map<String, dynamic>>(
          data: getBudgetWithMissingFieldResponse,
          requestOptions: RequestOptions(
            path: getBudgetValues.path,
          ),
        ));
      });

      final Either<Failure, ParentModel> result = await repo.get();

      expect(result, isA<Left>());
    });
  });

  group("budget categories test", () {
    //-----delete category testing----///
    test('verify that delete category success ', () async {
      when(budgetApi.delete("123"))
          .thenAnswer((Invocation realInvocation) async {
        return none();
      });

      final Option<Failure> result = await repo.delete('123');
      expect(result, isA<None>());
    });

    test('verify that delete category failed ', () async {
      when(budgetApi.delete("123"))
          .thenAnswer((Invocation realInvocation) async {
        return some(failure);
      });

      final Option<Failure> result = await repo.delete('123');
      final Failure? model = result.fold(() => null, (Failure a) => a);
      expect(model, isA<ApiFailure>());
    });

    //-----update category testing----///
    test('verify that update category success ', () async {
      when(budgetApi.update(updateBudgetSuccessBody))
          .thenAnswer((Invocation realInvocation) async {
        return right(Response<Map<String, dynamic>>(
            data: updateBudgetCategoryValues.successfulResponse,
            requestOptions: RequestOptions(
              path: updateBudgetCategoryValues.path,
            )));
      });

      final Either<Failure, BudgetCategoryModel> result =
          await repo.update(updateBudgetSuccessBody);
      final BudgetCategoryModel? model =
          result.fold((Failure l) => null, (BudgetCategoryModel r) => r);
      expect(model, equals(categoryModel));
    });

    test('verify that update category failed ', () async {
      when(budgetApi.update(updateBudgetSuccessBody))
          .thenAnswer((Invocation realInvocation) async {
        return left(failure);
      });

      final Either<Failure, BudgetCategoryModel> result =
          await repo.update(updateBudgetSuccessBody);
      final Object model =
          result.fold((Failure l) => l, (BudgetCategoryModel r) => r);
      expect(model, isA<ApiFailure>());
    });

    //-----add category testing----///
    test('verify that add category success ', () async {
      when(budgetApi.create(addBudgetSuccessBody))
          .thenAnswer((Invocation realInvocation) async {
        return right(Response<Map<String, dynamic>>(
            data: addBudgetCategoryValues.successfulResponse,
            requestOptions: RequestOptions(
              path: addBudgetCategoryValues.path,
            )));
      });

      final Either<Failure, BudgetCategoryModel> result =
          await repo.create(addBudgetSuccessBody);
      final BudgetCategoryModel? model =
          result.fold((Failure l) => null, (BudgetCategoryModel r) => r);
      expect(model, equals(categoryModel));
    });

    test('verify that add category failed ', () async {
      when(budgetApi.create(addBudgetSuccessBody))
          .thenAnswer((Invocation realInvocation) async {
        return left(failure);
      });

      final Either<Failure, BudgetCategoryModel> result =
          await repo.create(addBudgetSuccessBody);
      final Object model =
          result.fold((Failure l) => l, (BudgetCategoryModel r) => r);
      expect(model, isA<ApiFailure>());
    });
  });
}
