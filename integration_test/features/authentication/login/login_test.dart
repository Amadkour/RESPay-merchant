import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../helper/helper.dart';
import '../../../shared/values.dart';
import '../../../start_app_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('login flow', () {
    testWidgets('login flow', (WidgetTester tester) async {
      ///start app
      await startApp(tester);
      await login(tester);
    });
  });
}

Future<void> login(WidgetTester tester,
    {String? identityId, String? password, bool withId = true, String? phone}) async {
  if (withId) {
    /// Enter id number
    await isPresent(idControllerFinder, tester);
    await tester.enterText(idControllerFinder, '');
    await tester.enterText(idControllerFinder, identityId ?? '20222022');
    await tester.pumpAndSettle();
  } else {
    await isPresent(phoneNumberTextFieldFinder, tester);
    await tester.enterText(phoneNumberTextFieldFinder, '');
    await tester.enterText(phoneNumberTextFieldFinder, phone ?? '0584839292');
    await tester.pumpAndSettle();
  }

  /// Enter password
  await tester.enterText(passwordControllerFinder, '');
  await tester.pumpAndSettle();
  await tester.enterText(passwordControllerFinder, password ?? 'Mobile@2022');
  await tester.pumpAndSettle();

  /// Tap login button
  await ensureWidgetIsVisible(tester, loginButtonFinder);
  await tester.tap(loginButtonFinder);
  await tester.pumpAndSettle();
}
