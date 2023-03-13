import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';

import '../../../helper/helper.dart';
import '../../../shared/values.dart';
import '../../../start_app_test.dart';
import '../login/login_test.dart';

void main() async {
  group('forget password test', () {
    testWidgets('forget password test', (WidgetTester tester) async {
      await startApp(tester);
      await forgetPasswordTest(tester);
    });
  });
}

Future<void> forgetPasswordTest(WidgetTester tester,
    {String? identityId, String? password, bool fromLogin = true}) async {
  if (fromLogin) {
    /// Tap on forget password button
    await tester.tap(forgetPasswordFinder);
    await tester.pumpAndSettle();

    /// Tap on id expansion
    final Finder icon = find.byIcon(Icons.expand_more).last;
    await tester.tap(icon);
    await tester.pumpAndSettle();
  }

  /// fill id text field
  await tester.enterText(idForgetPasswordTextFieldFinder, identityId ?? '20222022');
  await tester.pumpAndSettle();

  /// scroll and tap confirm button
  await scroll(tester, confirmButtonForgetPasswordFinder, forgetPasswordListFinder);

  /// write pin code
  await writeCode(tester, code: otp);

  /// write new password
  await tester.enterText(createNewPassTextFieldFinder, password ?? 'Mobile@2022');
  await tester.pumpAndSettle();

  /// confirm new password
  await tester.enterText(confirmCreateNewPassTextFieldFinder, password ?? 'Mobile@2022');
  await tester.pumpAndSettle();

  await scroll(tester, confirmButtonCreateNewPasswordFinder, createPasswordListFinder);
  await login(tester, identityId: identityId, password: password);
}
