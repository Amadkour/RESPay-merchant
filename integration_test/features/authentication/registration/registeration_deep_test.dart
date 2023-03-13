import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';

import '../../../helper/helper.dart';
import '../../../shared/values.dart';
import '../authentication_flow_test.dart';
import '../validation_messages.dart';
import 'regestration_test.dart';

void main() {
  testWidgets("testing deep scenarios of registration", (WidgetTester tester) async {
    await registrationDeepTest(tester);
  });
}

Future<void> registrationDeepTest(WidgetTester tester) async {
  await startupWithSignUp(tester);

  ///test enter invalid inputs cases
  await _enterInvalidData(tester);

  /// test enter already registered data
  await _enterRegisteredData(tester);

  /// test success case
  await fillRegisterData(tester);

  //enter invalid otp
  await writeCode(tester, code: "1111");

  await tester.pumpAndSettle();

  await writeCode(tester, code: otp);
  await tester.pumpAndSettle();

  await writeCode(tester, code: pinCode);
  await tester.pumpAndSettle();

  await waitUntilVisible(tester, moreIconFinder);
  await logout(tester);
}

Future<void> _enterRegisteredData(WidgetTester tester) async {
  await _enterId(tester, valid: true);
  await _enterDate(tester, valid: true);
  await _enterPhone(tester, valid: true);
  await _enterEmail(tester, valid: true);
  await _enterPassword(tester, valid: true);
  await _enterPasswordConfirmation(tester, valid: true);
  await scroll(tester, registerConfirmButtonFinder, find.byType(SingleChildScrollView));
  await tester.pumpAndSettle();
}

Future<void> _enterInvalidData(WidgetTester tester) async {
  await _enterName(tester);

  /// trying to add id as string not numbers
  await _enterId(tester);

  /// enter not valid birth date
  await _enterDate(tester);

  /// enter invalid phone number
  await _enterPhone(tester);

  /// enter invalid email
  await _enterEmail(tester);

  /// enter invalid password
  await _enterPassword(tester);

  //correct password to check confirm password validation
  await _enterPasswordConfirmation(tester);

  await scroll(tester, registerConfirmButtonFinder, find.byType(SingleChildScrollView));
  await tester.pumpAndSettle();

  expect(loadingFinder, findsNothing);
}

Future<void> _enterPasswordConfirmation(WidgetTester tester, {bool valid = false}) async {
  await tester.enterText(registerConfirmPasswordTextFieldFinder, valid ? "Aa@123456" : "123456");
  await tester.pumpAndSettle();
  expect(isValid(tester, passwordConfirmationError), valid);
}

Future<void> _enterPassword(WidgetTester tester, {bool valid = false}) async {
  await tester.enterText(registerPasswordTextFieldFinder, valid ? "Aa@123456" : "12345");
  await tester.pumpAndSettle();

  expect(isValid(tester, passwordError), valid);
}

Future<void> _enterEmail(WidgetTester tester, {bool valid = false}) async {
  await tester.enterText(registerEmailTextFieldFinder, valid ? "hadykame@gmail.com" : 'hady.com');
  await tester.pumpAndSettle();

  expect(isValid(tester, emailError), valid);
}

Future<void> _enterPhone(WidgetTester tester, {bool valid = false}) async {
  await tester.enterText(registerPhoneNumberTextFieldFinder, valid ? "0566499165" : "01019069361");

  await tester.pumpAndSettle();

  expect(isValid(tester, phoneError), valid);
}

Future<void> _enterDate(WidgetTester tester, {bool valid = false}) async {
  await tester.tap(registerDateTextFieldFinder);
  await tester.pumpAndSettle();

  if (valid) {
    await tester.drag(find.text('2005'), const Offset(0, 8 * 32), warnIfMissed: false);
  } else {
    await scroll(tester, find.text('2008'), find.byKey(const Key("date_picker")));
  }

  await tester.pumpAndSettle();
  await clickOnButton(tester, datePickedButtonFinder);
  expect(isValid(tester, birthdayError), valid);
}

Future<void> _enterId(WidgetTester tester, {bool valid = false}) async {
  await tester.enterText(registerIDNumberTextFieldFinder, valid ? "20222022" : "12");
  await tester.pumpAndSettle();
  expect(isValid(tester, idError), valid);
}

Future<void> _enterName(WidgetTester tester) async {
  await tester.enterText(registerFullNameTextFieldFinder, "hady mohamed");
  await tester.pumpAndSettle();
}
