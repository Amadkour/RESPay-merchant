import 'package:flutter_test/flutter_test.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/main.dart' as app;

import '../../../helper/helper.dart';
import '../../../shared/values.dart';

void main() {
  group('Registration test', () {
    testWidgets('Registration test', (WidgetTester tester) async {
      await register(tester);
    });
  });
}

Future<void> register(WidgetTester tester,
    {void Function(String identityId, String password)? onSuccess, bool startWithSignUp = true}) async {
  if (startWithSignUp) {
    await startupWithSignUp(tester);
  }
  await fillRegisterData(tester, onSuccess: onSuccess);

  /// write otp code
  await writeCode(tester, code: otp);
  await tester.pumpAndSettle();

  /// write pin code
  await writeCode(tester, code: pinCode);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();
  await waitUntilVisible(tester, moreIconFinder);
  await tester.pumpAndSettle();
}

Future<void> startupWithSignUp(WidgetTester tester) async {
  app.main();
  await sl<LocalStorageService>().removeSession();
  await tester.pumpAndSettle();
  if (tester.any(goToSignupFinder)) {
    await isPresent(goToSignupFinder, tester);
    await tester.tap(goToSignupFinder);
  } else {
    await tester.tapAt(const Offset(100, 100));
    await isPresent(goToSignupFinder, tester);
    await tester.tap(goToSignupFinder);
  }
  await tester.pumpAndSettle();
}

Future<void> fillRegisterData(WidgetTester tester,
    {void Function(String identityId, String password)? onSuccess}) async {
  await ensureWidgetIsVisible(tester, registerFullNameTextFieldFinder);
  await tester.enterText(registerFullNameTextFieldFinder, "Mohamed");
  await tester.pumpAndSettle();

  final String randomID = generateRandomNumber(10000000, 99999999).toString();
  final String randomPass = "Mobile@$randomID";
  await ensureWidgetIsVisible(tester, registerIDNumberTextFieldFinder);
  await tester.enterText(registerIDNumberTextFieldFinder, randomID);
  await tester.pumpAndSettle();

  await tester.tap(registerDateTextFieldFinder);
  await tester.pumpAndSettle();

  await tester.tap(datePickedButtonFinder);
  await tester.pumpAndSettle();

  final String phoneNumber = '05$randomID';
  await tester.enterText(registerPhoneNumberTextFieldFinder, phoneNumber);
  await tester.pumpAndSettle();

  await ensureWidgetIsVisible(tester, registerEmailTextFieldFinder);
  await tester.enterText(registerEmailTextFieldFinder, "mohamed$randomID@gmail.com");
  await tester.pumpAndSettle();

  await ensureWidgetIsVisible(tester, registerPasswordTextFieldFinder);
  await tester.enterText(registerPasswordTextFieldFinder, randomPass);
  await tester.pumpAndSettle();

  await ensureWidgetIsVisible(tester, registerConfirmPasswordTextFieldFinder);
  await tester.enterText(registerConfirmPasswordTextFieldFinder, randomPass);
  await tester.pumpAndSettle();

  await ensureWidgetIsVisible(tester, registerConfirmButtonFinder);
  await tester.tap(registerConfirmButtonFinder);
  await tester.pumpAndSettle();
  onSuccess?.call(randomID, randomPass);
}
