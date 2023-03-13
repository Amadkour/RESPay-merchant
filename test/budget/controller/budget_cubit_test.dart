// ignore_for_file: always_specify_types

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/controller/budget_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/model/budget_list_model.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/repo/budget_repo.dart';

import '../provider/budget_values.dart';
import 'budget_cubit_test.mocks.dart';

@GenerateMocks(<Type>[BudgetRepo])
void main() {
  late MockBudgetRepo repo;

  setUpAll(() {
    repo = MockBudgetRepo();
  });

  group("testing  loadBudget method", () {
    blocTest<BudgetCubit, BudgetState>(
      "verify that get budget category return success",
      build: () {
        return BudgetCubit(repo: repo);
      },
      setUp: () {
        when(repo.get(period: "weekly")).thenAnswer(
          (Invocation realInvocation) async => right(
            budgetParentModel,
          ),
        );
      },
      act: (bloc) => bloc.loadBudget(),
      expect: () => [isA<BudgetLoading>(), isA<BudgetCategoriesLoaded>()],
      verify: (BudgetCubit bloc) {
        return verify(repo.get(period: "weekly")).called(1);
      },
    );

    blocTest<BudgetCubit, BudgetState>(
      "verify that get budget category return failure state",
      build: () {
        return BudgetCubit(repo: repo);
      },
      setUp: () {
        when(repo.get(period: "weekly")).thenAnswer(
          (Invocation realInvocation) async => left(
            ServerFailure(),
          ),
        );
      },
      act: (bloc) => bloc.loadBudget(),
      expect: () => [isA<BudgetLoading>(), isA<BudgetError>()],
      verify: (BudgetCubit bloc) {
        return verify(repo.get(period: "weekly")).called(1);
      },
    );
  });

  group("testing  addCategory method", () {
    blocTest<BudgetCubit, BudgetState>(
      "verify that add budget category return success",
      build: () {
        return BudgetCubit(repo: repo);
      },
      setUp: () {
        when(repo.create(updateBudgetSuccessBody)).thenAnswer(
          (Invocation realInvocation) async => right(
            budgetCategory,
          ),
        );
      },
      act: (bloc) {
        bloc.model = budgetParentModel as BudgetListModel;
        bloc.input = updateBudgetSuccessBody;
        return bloc.addCategory();
      },
      expect: () => [isA<BudgetLoading>(), isA<BudgetCategoryAdded>()],
      verify: (BudgetCubit bloc) {
        return verify(repo.create(updateBudgetSuccessBody)).called(1);
      },
    );

    blocTest<BudgetCubit, BudgetState>(
      "verify that add budget category return failure state",
      build: () {
        return BudgetCubit(repo: repo);
      },
      act: (bloc) {
        bloc.input = updateBudgetSuccessBody;
        return bloc.addCategory();
      },
      setUp: () {
        when(repo.create(updateBudgetSuccessBody)).thenAnswer(
          (Invocation realInvocation) async => left(
            ServerFailure(),
          ),
        );
      },
      expect: () => [isA<BudgetLoading>(), isA<BudgetError>()],
      verify: (BudgetCubit bloc) {
        return verify(repo.create(updateBudgetSuccessBody)).called(1);
      },
    );
  });

  group("testing  updateCategory method", () {
    blocTest<BudgetCubit, BudgetState>(
      "verify that update budget category return success",
      build: () {
        return BudgetCubit(repo: repo);
      },
      setUp: () {
        when(repo.update(updateBudgetSuccessBody)).thenAnswer(
          (Invocation realInvocation) async => right(
            budgetCategory,
          ),
        );
      },
      act: (bloc) {
        bloc.model = budgetParentModel as BudgetListModel;
        bloc.input = updateBudgetSuccessBody;

        return bloc.updateCategory();
      },
      expect: () => [isA<BudgetLoading>(), isA<BudgetCategoryAdded>()],
      verify: (BudgetCubit bloc) {
        return verify(repo.update(updateBudgetSuccessBody)).called(1);
      },
    );

    blocTest<BudgetCubit, BudgetState>(
      "verify that update budget category return failure state",
      build: () {
        return BudgetCubit(repo: repo);
      },
      act: (bloc) {
        bloc.input = updateBudgetSuccessBody;
        return bloc.updateCategory();
      },
      setUp: () {
        when(repo.update(updateBudgetSuccessBody)).thenAnswer(
          (Invocation realInvocation) async => left(
            ServerFailure(),
          ),
        );
      },
      expect: () => [isA<BudgetLoading>(), isA<BudgetError>()],
      verify: (BudgetCubit bloc) {
        return verify(repo.update(updateBudgetSuccessBody)).called(1);
      },
    );
  });

  group("testing  deleteCategory method", () {
    blocTest<BudgetCubit, BudgetState>(
      "verify that delete budget category return success",
      build: () {
        return BudgetCubit(repo: repo);
      },
      setUp: () {
        when(repo.delete(any)).thenAnswer(
          (Invocation realInvocation) async => none(),
        );
      },
      act: (bloc) {
        bloc.model = budgetParentModel as BudgetListModel;

        bloc.delete("uuid");
        bloc.removeCategory(0);
      },
      expect: () => [isA<BudgetLoading>(), isA<BudgetCategoryDeleted>()],
      verify: (BudgetCubit bloc) {
        return verify(repo.delete(any)).called(1);
      },
    );

    blocTest<BudgetCubit, BudgetState>(
      "verify that delete budget category return failure state",
      build: () {
        return BudgetCubit(repo: repo);
      },
      act: (bloc) {
        bloc.model = budgetParentModel as BudgetListModel;

        return bloc.delete("uuid");
      },
      setUp: () {
        when(repo.delete(any)).thenAnswer(
          (Invocation realInvocation) async => some(
            ServerFailure(),
          ),
        );
      },
      expect: () => [isA<BudgetLoading>(), isA<BudgetError>()],
      verify: (BudgetCubit bloc) {
        return verify(repo.delete(any)).called(1);
      },
    );
  });

  group("testing  toggleCategory method", () {
    blocTest<BudgetCubit, BudgetState>(
      "verify that toggle budget category return success",
      build: () {
        return BudgetCubit(repo: repo);
      },
      setUp: () {
        when(repo.toggleCategory(any)).thenAnswer(
          (Invocation realInvocation) async => none(),
        );
      },
      act: (bloc) {
        bloc.model = budgetParentModel as BudgetListModel;

        return bloc.toggleCategory("uuid");
      },
      expect: () => [isA<BudgetCategoryLoading>(), isA<BudgetCategoryToggle>()],
      verify: (BudgetCubit bloc) {
        return verify(repo.toggleCategory(any)).called(1);
      },
    );

    blocTest<BudgetCubit, BudgetState>(
      "verify that toggle category return failure state",
      build: () {
        return BudgetCubit(repo: repo);
      },
      act: (bloc) {
        bloc.model = budgetParentModel as BudgetListModel;

        return bloc.toggleCategory("uuid");
      },
      setUp: () {
        when(repo.toggleCategory(any)).thenAnswer(
          (Invocation realInvocation) async => some(
            ServerFailure(),
          ),
        );
      },
      expect: () => [isA<BudgetCategoryLoading>(), isA<BudgetError>()],
      verify: (BudgetCubit bloc) {
        return verify(repo.toggleCategory(any)).called(1);
      },
    );
  });

  group("testing  setters methods", () {
    blocTest<BudgetCubit, BudgetState>(
      "test change category method",
      build: () {
        return BudgetCubit(repo: repo);
      },
      act: (bloc) {
        bloc.model = budgetParentModel as BudgetListModel;
        bloc.changeCategory(
          bloc.model.categoryTypes.first,
        );
      },
      expect: () => [isA<BudgetSelectCategory>()],
      verify: (bloc) => expect(bloc.input.parentCategoryUuid, bloc.model.categoryTypes.first.uuid),
    );

    blocTest<BudgetCubit, BudgetState>(
      "test initForEdit method",
      build: () {
        return BudgetCubit(repo: repo);
      },
      act: (bloc) {
        bloc.model = budgetParentModel as BudgetListModel;
        bloc.initCategoryForEdit(bloc.model.categories.first);
      },
      verify: (bloc) => expect(bloc.input.uuid, bloc.model.categories.first.uuid),
    );
  });
}
