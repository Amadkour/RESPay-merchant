import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/helper.dart';
import '../../../../shared/values.dart';
import '../../../../start_app_test.dart';
import '../../../authentication/login/login_test.dart';

void main() {
  group('about Testing', () {
    testWidgets('about Testing', (WidgetTester tester) async {
      await startApp(tester);

      await login(tester);

      await aboutTest(tester);
    });
  });
}

Future<void> aboutTest(WidgetTester tester) async {
  /// Go to about page
  await goToBottomMoreIconAndOpenItem(aboutUsFinder, tester, isLogin: true);

  await back(tester);
  await tester.pumpAndSettle();
  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle();
}
