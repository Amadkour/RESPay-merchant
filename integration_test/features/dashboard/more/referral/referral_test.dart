import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../../../helper/helper.dart';
import '../../../../shared/values.dart';
import '../../../../start_app_test.dart';
import '../../../authentication/login/login_test.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("test referral flow", (WidgetTester tester) async {
    await startApp(tester);

    await login(tester);

    await referralTest(tester);
  });
}

Future<void> referralTest(WidgetTester tester) async {
  await goToBottomMoreIconAndOpenItem(referralIconFinder, tester,
      isLogin: true);
  await clickOnButton(tester, referralsTapFinder);
  await clickOnButton(tester, inviteFriendTapFinder);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await back(tester);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle(const Duration(seconds: 1));
}

Future<void> referralDeepTest(WidgetTester tester) async {
  await goToBottomMoreIconAndOpenItem(referralIconFinder, tester,
      isLogin: true);

  /// Test copy button
  await tester.tap(copyReferralLinkFinder);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  /// Test others button
  await tester.tap(othersReferralLinkFinder);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await back(tester);
  await tester.pumpAndSettle();

  await tester.tap(referralsTapFinder);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await back(tester);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle(const Duration(seconds: 1));
}
