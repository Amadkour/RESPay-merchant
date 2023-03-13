import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../../helper/helper.dart';
import '../../../../shared/values.dart';
import '../../../../start_app_test.dart';
import '../../../authentication/login/login_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("test promotions flow ", () {
    testWidgets('test promotions flow', (WidgetTester tester) async {
      await startApp(tester);
      await login(tester);

      await promotionsFlow(tester);
    });
  });
}

Future<void> promotionsFlow(WidgetTester tester) async {
  await tester.tap(moreIconFinder);
  await tester.pumpAndSettle();
  await scroll(tester, promotionsFinder, moreListFinder);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();
  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle();
}

Future<void> promotionDeepTest(WidgetTester tester) async {
  await goToBottomMoreIconAndOpenItem(promotionsFinder, tester, isLogin: true);

  /// tap on promotion
  await tester.tap(promotionItemFinder);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();

  /// test search
  await tester.tap(searchIconFinder);
  await tester.pumpAndSettle();
  await tester.enterText(historySearchTextFieldFinder, 'a');
  await tester.pumpAndSettle();

  /// back to home
  await back(tester);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();

  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle();
}
