import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/helper.dart';
import '../../../../shared/values.dart';
import '../../../../start_app_test.dart';
import '../../../authentication/login/login_test.dart';

void main() {
  group('Terms Testing', () {
    testWidgets('Terms Testing', (WidgetTester tester) async {
      /// Go to terms and conditions page
      await startApp(tester);

      await login(tester);

      await termsTest(tester);
    });
  });
}

Future<void> termsTest(WidgetTester tester) async {
  await goToBottomMoreIconAndOpenItem(termOfConditionsFinder, tester,
      isLogin: true);

  /// tap on term item (expand/collapse)
  await tester.tap(termsListTileFinder);
  await tester.pumpAndSettle();
  await tester.tap(termsListTileFinder);
  await tester.pumpAndSettle();

  /// back and go to home
  await back(tester);
  await tester.pumpAndSettle();
  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle();
}
