import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/view/component/budget_category_widget.dart';

import '../../helper/helper.dart';
import '../../shared/values.dart';
import '../../start_app_test.dart';
import '../authentication/login/login_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("test budget flow ", () {
    testWidgets('test view budget view', (WidgetTester tester) async {
      await budgetTest(tester);
    });
  });
}

Future<void> budgetTest(WidgetTester tester, {bool withLogin = true}) async {
  if (withLogin) {
    await startApp(tester);
    await login(tester);
  }
  await tapMoreFinder(budgetFinder, tester, startFromInitApp: false);

  /// delete all existing categories
  await _clearAlreadyExistBudgets(tester);

  await _addCategory(tester);
  await _addCategory(tester, index: 2);

  await _changeFilterDuration(tester);

  await _testStatusSwitch(tester);

  await _updateBudgetCategory(tester);

  await _deleteCategory(tester);
  await back(tester);
  await tester.pumpAndSettle(const Duration(seconds: 3));
}

Future<void> _clearAlreadyExistBudgets(WidgetTester tester) async {
  final Iterable<Widget> existBudgets =
      tester.widgetList(find.bySubtype<BudgetCategoryWidget>());
  if (existBudgets.isNotEmpty) {
    for (int i = 0; i < existBudgets.length; i++) {
      await _deleteCategory(tester,
          finder: find.byKey(existBudgets.elementAt(i).key!));
    }
  }
}

Future<void> _testStatusSwitch(WidgetTester tester) async {
  await _scrollToCategory(tester);

  await isPresent(toggleBudgetSwitchFinder, tester);
  await tester.tap(toggleBudgetSwitchFinder.first);
  await tester.pumpAndSettle();
  await _selectCategory(tester);
  await tester.tap(toggleBudgetSwitchFinder.first);
  await tester.pumpAndSettle();
}

Future<void> _updateBudgetCategory(WidgetTester tester) async {
  await tester.tap(editBudgetCategoryButtonFinder);
  await tester.pumpAndSettle();
  await selectCategoryInputs(tester, "300", 5);
  await tester.tap(createBudgetButtonFinder);
  await tester.pumpAndSettle();
}

Future<void> _changeFilterDuration(WidgetTester tester) async {
  expect(budgetFilterDropdownFinder, findsOneWidget);
  await tester.tap(budgetFilterDropdownFinder);

  await tester.pumpAndSettle();

  await tester.tap(find.text("Monthly").last);
  await tester.pumpAndSettle();
}

Future<void> _deleteCategory(WidgetTester tester, {Finder? finder}) async {
  await _selectCategory(tester, finder: finder);
  await tester.tap(deleteBudgetButtonFinder);
  await tester.pumpAndSettle();
}

Future<void> _selectCategory(WidgetTester tester, {Finder? finder}) async {
  await _scrollToCategory(tester, finder: finder);
  await tester.tap(finder ?? find.bySubtype<BudgetCategoryWidget>().first);
  await tester.pumpAndSettle();
}

Future<void> _scrollToCategory(WidgetTester tester, {Finder? finder}) async {
  final Finder item = finder ?? find.bySubtype<BudgetCategoryWidget>().first;

  await scroll(tester, item, budgetScrollViewFinder, tapping: false);
  await tester.pumpAndSettle();
}

Future<void> _addCategory(WidgetTester tester, {int index = 1}) async {
  await isPresent(addNewBudgetButtonFinder, tester);
  await tester.tap(addNewBudgetButtonFinder);
  await tester.pumpAndSettle();
  expect(createBudgetButtonFinder, findsOneWidget);
  await selectCategoryInputs(tester, "500", index);
  await tester.tap(createBudgetButtonFinder);
  await tester.pumpAndSettle();
}

Future<void> selectCategoryInputs(
    WidgetTester tester, String amount, int categoryIndex) async {
  await tester.enterText(amountTextfieldFinder, amount);
  await tester.pumpAndSettle();
  await tester.tap(openBudgetCategoriesSheetFinder);
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(ValueKey<String>("budget_type_$categoryIndex")));
  await tester.pumpAndSettle();
}
