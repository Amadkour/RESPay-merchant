import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/helper.dart';
import '../../../../shared/values.dart';
import '../../../../start_app_test.dart';
import '../../../authentication/login/login_test.dart';

void main() {
  group('language Testing', () {
    testWidgets('language Testing', (WidgetTester tester) async {
      await startApp(tester);

      await login(tester);

      await languageTest(tester);
    });
  });
}

Future<void> languageTest(WidgetTester tester) async {
  /// Go to language page
  await goToBottomMoreIconAndOpenItem(changeLanguageFinder, tester,
      isLogin: true);

  /// Change language to arabic
  await tester.tap(arabicRadioButtonFinder);
  await tester.pumpAndSettle();

  /// Tap to confirmation button to change language to arabic
  await tester.tap(changeLanguageConfirmButtonFinder);
  await tester.pumpAndSettle();

  /// Back again to change language bottom sheet again and change language to english
  await scroll(tester, changeLanguageFinder, moreListFinder);
  await tester.tap(englishRadioButtonFinder);
  await tester.pumpAndSettle();

  /// Tap to confirmation button to change language to english
  await tester.tap(changeLanguageConfirmButtonFinder);
  await tester.pumpAndSettle();
  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle();
}
