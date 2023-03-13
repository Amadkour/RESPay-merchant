import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';

import '../../../helper/helper.dart';
import '../../../shared/values.dart';
import '../../../start_app_test.dart';
import '../authentication_flow_test.dart';
import '../login/login_test.dart';
import '../validation_messages.dart';

void main() {
  testWidgets('deep test of forget password flow', (WidgetTester tester) async {
    await forgetPasswordDeepTest(tester);
  });
}

Future<void> forgetPasswordDeepTest(WidgetTester tester, {bool fromStart = true}) async {
  if (fromStart) {
    await startApp(tester);
  }

  await _idResetFlow(tester);
  await _phoneResetFlow(tester);
}

Future<void> _phoneResetFlow(WidgetTester tester) async {
  await clickOnButton(tester, forgetPasswordFinder);
  await tester.pumpAndSettle();
  final Finder icon = find.byIcon(Icons.expand_more).first;
  await tester.tap(icon);
  await tester.pumpAndSettle();

  //enter invalid id
  await tester.enterText(phoneNumberTextFieldFinder, '12');
  await tester.pumpAndSettle();

  expect(isValid(tester, phoneError), false);

  ///enter not phone

  await tester.enterText(phoneNumberTextFieldFinder, '0566499167');
  await tester.pumpAndSettle();

  await scroll(tester, confirmButtonForgetPasswordFinder, forgetPasswordListFinder);

  /// inter valid data
  /// fill phone text field
  await tester.enterText(phoneNumberTextFieldFinder, '0566499165');
  await tester.pumpAndSettle();

  /// scroll and tap confirm button
  await scroll(tester, confirmButtonForgetPasswordFinder, forgetPasswordListFinder);

  //write valid otp
  await writeCode(tester, code: otp);

  /// write new password
  await tester.enterText(createNewPassTextFieldFinder, 'Aa@123456');
  await tester.pumpAndSettle();

  /// write new password confirmation
  await tester.enterText(confirmCreateNewPassTextFieldFinder, 'Aa@12345');
  await tester.pumpAndSettle();

  expect(isValid(tester, passwordConfirmationError), false);

  await tester.enterText(confirmCreateNewPassTextFieldFinder, 'Aa@123456');
  await tester.pumpAndSettle();

  /// test show and hide password
  await clickOnButton(tester, showPasswordFinder.first);
  await tester.pumpAndSettle();
  await clickOnButton(tester, showPasswordFinder.first);
  await tester.pumpAndSettle();

  ///  change password
  await scroll(tester, confirmButtonCreateNewPasswordFinder, createPasswordListFinder);

  await tester.tap(find.byKey(const ValueKey<int>(0)));
  await tester.pumpAndSettle();
  await login(tester, phone: '0566499165', password: "Aa@123456", withId: false);

  await logout(tester);
}

Future<void> _idResetFlow(WidgetTester tester) async {
  await clickOnButton(tester, forgetPasswordFinder);
  await tester.pumpAndSettle();
  final Finder icon = find.byIcon(Icons.expand_more).last;
  await tester.tap(icon);
  await tester.pumpAndSettle();

  //enter invalid id
  await tester.enterText(idForgetPasswordTextFieldFinder, '12');
  await tester.pumpAndSettle();

  expect(isValid(tester, idError), false);

  ///enter not registered id

  await tester.enterText(idForgetPasswordTextFieldFinder, '202220000');
  await tester.pumpAndSettle();

  await scroll(tester, confirmButtonForgetPasswordFinder, forgetPasswordListFinder);

  /// inter valid data
  /// fill id text field
  await tester.enterText(idForgetPasswordTextFieldFinder, '20222022');
  await tester.pumpAndSettle();

  /// scroll and tap confirm button
  await scroll(tester, confirmButtonForgetPasswordFinder, forgetPasswordListFinder);

  /// write invalid otp
  await writeCode(tester, code: '1111');
  //write valid otp
  await writeCode(tester, code: otp);

  /// write new password
  await tester.enterText(createNewPassTextFieldFinder, 'Mobile@2022');
  await tester.pumpAndSettle();

  /// write new password confirmation
  await tester.enterText(confirmCreateNewPassTextFieldFinder, 'Mobile@202');
  await tester.pumpAndSettle();

  expect(isValid(tester, passwordConfirmationError), false);

  await tester.enterText(confirmCreateNewPassTextFieldFinder, 'Mobile@2022');
  await tester.pumpAndSettle();

  /// test show and hide password
  await clickOnButton(tester, showPasswordFinder.first);
  await tester.pumpAndSettle();
  await clickOnButton(tester, showPasswordFinder.first);
  await tester.pumpAndSettle();

  ///  change password
  await scroll(tester, confirmButtonCreateNewPasswordFinder, createPasswordListFinder);
  await login(tester, identityId: '20222022', password: "Mobile@2022");

  await logout(tester);
}
