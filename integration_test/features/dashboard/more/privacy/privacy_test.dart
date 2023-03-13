import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/helper.dart';
import '../../../../shared/values.dart';
import '../../../../start_app_test.dart';
import '../../../authentication/login/login_test.dart';

void main() {
  group('privacy Testing', () {
    testWidgets('privacy Testing', (WidgetTester tester) async {
      await startApp(tester);

      await login(tester);

      await privacyTest(tester);
    });
  });
}

Future<void> privacyTest(WidgetTester tester) async {
  /// Go to privacy page
  await goToBottomMoreIconAndOpenItem(privacyPolicyFinder, tester,
      isLogin: true);

  /// tap on privacy item (expand/collapse)
  await tester.tap(privacyListTileFinder);
  await tester.pumpAndSettle();
  await tester.tap(privacyListTileFinder);
  await tester.pumpAndSettle();

  await back(tester);
  await tester.pumpAndSettle();
  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle();
}
