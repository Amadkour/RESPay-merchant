import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helper/helper.dart';
import '../../../shared/values.dart';
import '../../../start_app_test.dart';
import '../authentication_flow_test.dart';
import '../validation_messages.dart';
import 'login_test.dart';

void main() {
  testWidgets("deep test of login flow ", (WidgetTester tester) async {
    await loginDeepTest(tester);
  });
}

Future<void> loginDeepTest(WidgetTester tester, {bool fromStart = true}) async {
  if (fromStart) {
    await startApp(tester);
  }

  /// enter invalid phone
  await tester.tap(find.byKey(const ValueKey<int>(0)));

  await tester.pumpAndSettle();

  await tester.enterText(phoneNumberTextFieldFinder, "05664991");
  await tester.pumpAndSettle();
  expect(isValid(tester, phoneError), false);

  await tester.enterText(passwordControllerFinder, "11111");
  await tester.pumpAndSettle();

  await clickOnButton(tester, loginButtonFinder);

  /// login with invalid id
  await tester.tap(find.byKey(const ValueKey<int>(1)));

  await tester.pumpAndSettle();

  await tester.enterText(idControllerFinder, "1234");
  await tester.pumpAndSettle();

  expect(isValid(tester, idError), false);

  await tester.enterText(idControllerFinder, "20222022");
  await tester.pumpAndSettle();
  expect(isValid(tester, phoneError), true);

  //login with invalid password
  await tester.enterText(passwordControllerFinder, "Mobile@2023");
  await tester.pumpAndSettle();
  await clickOnButton(tester, loginButtonFinder);
  //login with valid id
  await login(tester);

  await waitUntilVisible(tester, moreIconFinder);

  await logout(tester);

  await tester.tap(find.byKey(const ValueKey<int>(0)));

  await tester.pumpAndSettle();
  //login with valid phone

  await tester.enterText(phoneNumberTextFieldFinder, "0584839292");
  await tester.pumpAndSettle();
  await tester.enterText(passwordControllerFinder, "Mobile@2022");
  await tester.pumpAndSettle();

  await clickOnButton(tester, loginButtonFinder);
  await tester.pumpAndSettle();

  await waitUntilVisible(tester, moreIconFinder);

  await logout(tester);
}
