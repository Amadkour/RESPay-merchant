import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../helper/helper.dart';
import '../../shared/values.dart';
import '../../start_app_test.dart';
import '../authentication/login/login_test.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("test orders flow", (WidgetTester tester) async {

    await startApp(tester);
    await login(tester);
    await ordersTest(tester);
  });
}


Future<void> ordersTest(WidgetTester tester) async {
  await goToBottomMoreIconAndOpenItem(
    ordersIconFinder,
    tester,
    isLogin: true,
  );

  /// test search flow
  await tester.enterText(orderSearchTextFieldFinder, 'ORD1');
  await tester.pumpAndSettle();

  /// test filter by status
  await tester.enterText(orderSearchTextFieldFinder, '');
  await tester.tap(find.byKey(const ValueKey<String>("pending")));
  await tester.pumpAndSettle();

  await scroll(tester, find.byKey(const ValueKey<String>("canceled")), find.byType(SingleChildScrollView).last);
  await tester.pumpAndSettle();

  await scroll(tester, find.byKey(const ValueKey<String>("delivered")), find.byType(SingleChildScrollView).last);
  await tester.pumpAndSettle();
  // test buy again
  if (tester.widgetList(buyAgainButtonFinder).isNotEmpty) {
    await tester.tap(buyAgainButtonFinder.first);
    await tester.pumpAndSettle();

    await back(tester);
    await tester.pumpAndSettle();
  }

  // test complain
  if (tester.widgetList(viewOrderDetailsButtonFinder).isNotEmpty) {
    await tester.tap(viewOrderDetailsButtonFinder.first);
    await tester.pumpAndSettle();
    await scroll(tester, complainButtonFinder, orderDetailsScrollViewFinder);

    await tester.tap(complainOrderReasonFinder);
    await tester.pumpAndSettle();
    await tester.tap(find.bySubtype<DropdownMenuItem<String>>().first);
    await tester.pumpAndSettle();
    await tester.enterText(descriptionTextfieldFinder, "i don't need it");
    await tester.pumpAndSettle();
    await tester.tap(sheetApplyButtonFinder);
    await tester.pumpAndSettle();

    await back(tester);
    await tester.pumpAndSettle();
  }

  await tester.tap(find.byKey(const ValueKey<String>("pending")));
  await tester.pumpAndSettle();
  if (tester.widgetList(viewOrderDetailsButtonFinder).isNotEmpty) {
    await tester.tap(find.byKey(const ValueKey<String>("pending")));
    await tester.pumpAndSettle();
    await tester.tap(viewOrderDetailsButtonFinder.first);
    await tester.pumpAndSettle();
    await scroll(tester, cancelOrderButtonFinder, orderDetailsScrollViewFinder);
    await tester.enterText(descriptionTextfieldFinder, "i don't need it");

    await tester.pumpAndSettle();
    await tester.tap(sheetApplyButtonFinder);
    await tester.pumpAndSettle();

    await back(tester);
    await tester.pumpAndSettle();
  }
  await _backHome(tester);
}

Future<void> _backHome(WidgetTester tester) async {
  await back(tester);
  await tester.pumpAndSettle();

  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle();
}
