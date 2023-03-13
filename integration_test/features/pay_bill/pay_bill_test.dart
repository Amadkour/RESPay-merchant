import 'package:flutter_test/flutter_test.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import '../../helper/helper.dart';
import '../../shared/values.dart';
import '../../start_app_test.dart';
import '../authentication/login/login_test.dart';

void main() {
  group('pay bill integration test flow', () {
    testWidgets('pay bill test......', (WidgetTester tester) async {
      await deepPayBill(tester);
    });
  });
}

Future<void> payBill(WidgetTester tester, {bool withLogin = true}) async {
  if (withLogin) {
    await startApp(tester);
    await login(tester);
  }
  await tapMoreAfterLogin(
    tester,
    billFinder,
  );

  ///select company
  final Finder dropdownItem = find.text(tr('Electricity')).last;
  await selectFromDropDownList(tester, dropdownItem, selectCompanyFinder);
  await tester.pumpAndSettle();

  /// customer id number
  await isPresent(customerIdFinder, tester);
  await tester.enterText(customerIdFinder, '1122334455665544323');
  await tester.pumpAndSettle();

  /// Tap to see bill
  await isPresent(seeBillFinder, tester);
  await tester.tap(seeBillFinder);
  await tester.pumpAndSettle();

  /// Tap to add  bank account
  await isPresent(payNowFinder, tester);
  await tester.tap(payNowFinder);
  await tester.pumpAndSettle();

  await writeCode(tester);
  await tester.pumpAndSettle();
  await waitUntilVisible(tester, viewEReceiptFinder);
  await clickOnButton(tester, viewEReceiptFinder);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await clickOnButton(tester, closeScreenButton);
}

Future<void> deepPayBill(WidgetTester tester, {bool withLogin = true}) async {
  if (withLogin) {
    await startApp(tester);
    await login(tester);
  }
  await tapMoreAfterLogin(
    tester,
    billFinder,
  );

  ///select company
  final Finder dropdownItem = find.text(tr('Electricity')).last;
  await selectFromDropDownList(tester, dropdownItem, selectCompanyFinder);
  await tester.pumpAndSettle();

  /// customer id number
  await isPresent(customerIdFinder, tester);
  await tester.enterText(customerIdFinder, '112233445566554432388');
  await tester.pumpAndSettle();

  /// Tap to see bill
  await isPresent(seeBillFinder, tester);
  await tester.tap(seeBillFinder);
  await tester.pumpAndSettle();

  /// Tap to add  bank account
  await isPresent(payNowFinder, tester);
  await tester.tap(payNowFinder);
  await tester.pumpAndSettle();

  await writeCode(tester);
  await tester.pumpAndSettle();
  await waitUntilVisible(tester, viewEReceiptFinder);
  await clickOnButton(tester, viewEReceiptFinder);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await clickOnButton(tester, closeScreenButton);
}
