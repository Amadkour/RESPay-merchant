import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../../helper/helper.dart';
import '../../../../shared/values.dart';
import '../../../../start_app_test.dart';
import '../../../authentication/login/login_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("test support flow ", () {
    testWidgets('test send issue flow', (WidgetTester tester) async {
      await startApp(tester);
      await login(tester);
      await supportFlow(tester);
    });
  });
}

Future<void> supportFlow(WidgetTester tester) async {
  await tester.tap(moreIconFinder);
  await tester.pumpAndSettle();
  await scroll(tester, supportFinder, moreListFinder);

  /// fill first name text field
  await fillTextField(tester, firstNameTextFieldFinder, "hussein hamed");

  /// fill email text field
  await fillTextField(tester, emailTextFieldFinder, "test@gmail.com");

  /// fill support message text field
  await fillTextField(tester, supportMessageTextFieldFinder, "first issue");

  /// tap on send button
  await scroll(tester, sendButtonFinder, sendIssueScrollListFinder);
  await tester.pumpAndSettle();
  await waitUntilVisible(tester, backToHomeDialogFinder);
  await tester.tap(backToHomeDialogFinder);
  await tester.pumpAndSettle();
}
