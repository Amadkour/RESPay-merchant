import 'package:flutter_test/flutter_test.dart';
import '../../../../helper/helper.dart';
import '../../../../shared/values.dart';
import '../../../../start_app_test.dart';
import '../../../authentication/login/login_test.dart';

void main() {
  group('customer loyalty test flow...', () {
    testWidgets('test flow..', (WidgetTester tester) async {
      await customerLoyalty(tester);
    });
  });
}

Future<void> customerLoyalty(WidgetTester tester,
    {bool isLogin = false}) async {
  if (!isLogin) {
    await startApp(tester);

    await login(tester);
  }
  await goToBottomMoreIconAndOpenItem(customerLoyaltyFinder, tester,
      isLogin: true);

  /// Tap to select item
  await isPresent(selectItemFinder, tester);
  await tester.tap(selectItemFinder);
  await tester.pumpAndSettle();

  await isPresent(redeemFinder, tester);
  await tester.tap(redeemFinder);
  await tester.pumpAndSettle();

  await isPresent(viewEReceiptFinder, tester);
  await tester.tap(viewEReceiptFinder);
  await tester.pumpAndSettle();

  await back(tester);
  await tester.pumpAndSettle();

  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle();
}

Future<void> customerLoyaltyDeepTest(WidgetTester tester) async {
  await goToBottomMoreIconAndOpenItem(customerLoyaltyFinder, tester,
      isLogin: true);

  /// Tap to select item
  await _selectItemAndPressRedeem(tester);

  /// test if we pressed back on the success dialog
  await waitUntilVisible(tester, backToHomeDialogFinder);
  await isPresent(viewEReceiptFinder, tester);
  await tester.tap(viewEReceiptFinder);
  await tester.pumpAndSettle();

  await _selectItemAndPressRedeem(tester);
  await tester.pumpAndSettle();

  /// test if we pressed (go to home) on the success dialog
  await waitUntilVisible(tester, backToHomeDialogFinder);
  await isPresent(backToHomeDialogFinder, tester);
  await tester.tap(backToHomeDialogFinder);
  await tester.pumpAndSettle();
}

Future<void> _selectItemAndPressRedeem(WidgetTester tester) async {
  await isPresent(selectItemFinder, tester);
  await tester.tap(selectItemFinder);
  await tester.pumpAndSettle();

  await isPresent(redeemFinder, tester);
  await tester.tap(redeemFinder);
  await tester.pumpAndSettle();
}
