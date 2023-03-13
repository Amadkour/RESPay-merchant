import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../helper/helper.dart';
import '../../shared/values.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('test history flow', (WidgetTester tester) async {
    await historyTest(tester);
  });
}

Future<void> historyTest(WidgetTester tester, {bool withLogin = true}) async {
  await tapMoreFinder(historyFinder, tester, startFromInitApp: withLogin);
  await _testSearchFlow(tester);

  await _filterByCategory(tester);

  await _periodFilterFlow(tester);
  await back(tester);
  await tester.pumpAndSettle();
}

Future<void> _periodFilterFlow(WidgetTester tester) async {
  /// filter history by choosing only period
  /// and leaves dates empty
  await _filterByPeriodOnly(tester);

  await tester.tap(sheetApplyButtonFinder);
  await tester.pumpAndSettle();

  /// test case if user enter only from date
  /// we clear period data first and then set date
  await _resetPeriodValue(tester);
  await _resetToDate(tester);
  await _filterByFromDateOnly(tester);

  await tester.tap(sheetApplyButtonFinder);
  await tester.pumpAndSettle();

  /// test case if user enter only to date
  /// we clear period data first and then set date
  await _resetPeriodValue(tester);
  await _resetFromDate(tester);
  await _filterByToDateOnly(tester);

  await tester.tap(sheetApplyButtonFinder);
  await tester.pumpAndSettle();

  /// test case user enter all data in sheet

  await _filterByPeriodOnly(tester);
  await _filterByFromDateOnly(tester);
  await _filterByToDateOnly(tester);
  await tester.tap(sheetApplyButtonFinder);
  await tester.pumpAndSettle();

  /// test case use tap cancel button
  await _openSheet(tester);

  await tester.tap(sheetCancelButtonFinder);
  await tester.pumpAndSettle();
}

Future<void> _resetPeriodValue(WidgetTester tester) async {
  await _openSheet(tester);
  await tester.tap(clearPeriodButtonFinder);
  await tester.pumpAndSettle();
}

Future<void> _filterByFromDateOnly(WidgetTester tester) async {
  await tester.tap(selectHistoryPeriodFromButtonFinder);
  await tester.pumpAndSettle();
  await _pickDate(tester);
}

Future<void> _openSheet(WidgetTester tester) async {
  await tester.tap(historyDurationFilterFinder);
  await tester.pumpAndSettle();
}

Future<void> _filterByToDateOnly(WidgetTester tester) async {
  await tester.tap(selectHistoryPeriodToButtonFinder);
  await tester.pumpAndSettle();
  await _pickDate(tester);
}

Future<void> _filterByPeriodOnly(WidgetTester tester) async {
  await isPresent(historyDurationFilterFinder, tester);
  await tester.tap(historyDurationFilterFinder);
  await tester.pumpAndSettle();
  await tester.tap(periodDropdownFinder);
  await tester.pumpAndSettle();
  await tester.tap(find.text("Last 7 days").first);
  await tester.pumpAndSettle();
}

Future<void> _pickDate(WidgetTester tester) async {
  await tester.tap(datePickedButtonFinder);
  await tester.pumpAndSettle();
}

Future<void> _filterByCategory(WidgetTester tester) async {
  await tester.tap(historyCategoryFilterFinder);
  await tester.pumpAndSettle();

  await tester.tap(find.byKey(const ValueKey<int>(0)));
  await tester.pumpAndSettle();
}

Future<void> _testSearchFlow(WidgetTester tester) async {
  await tester.tap(historySearchButtonFinder);
  await tester.pumpAndSettle();
  await tester.enterText(historySearchTextFieldFinder, "12");
  await tester.pumpAndSettle();

  await tester.tap(searchClearTextFieldButtonFinder);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();
}

Future<void> _resetFromDate(WidgetTester tester) async {
  await tester.tap(clearFromDateButtonFinder);
  await tester.pumpAndSettle();
}

Future<void> _resetToDate(WidgetTester tester) async {
  await tester.tap(clearToDateButtonFinder);
  await tester.pumpAndSettle();
}
