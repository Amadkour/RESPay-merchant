import 'package:flutter_test/flutter_test.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

import '../../helper/helper.dart';
import '../../shared/values.dart';
import '../../start_app_test.dart';
import '../authentication/login/login_test.dart';

void main() {
  group('FAQs flow test.......', () {
    testWidgets('faqs test', (WidgetTester tester) async {
      await faqTest(tester);
    });
  });
}

Future<void> faqTest(WidgetTester tester, {bool isLogin = false}) async {
  if (!isLogin) {
    await startApp(tester);

    await login(tester);
  }
  await goToBottomMoreIconAndOpenItem(faqsFinder, tester, isLogin: true);

  await tester.tap(faqsTapFinder);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();
  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle();
}

Future<void> faqDeepTest(WidgetTester tester) async {
  await goToBottomMoreIconAndOpenItem(faqsFinder, tester, isLogin: true);
  await tester.tap(faqsTapFinder);
  await tester.pumpAndSettle();

  /// Test search
  await tester.enterText(faqSearchTextFieldFinder, 'a');
  await tester.pumpAndSettle();

  /// Test tap faq
  await tester.tap(faqsTapFinder);
  await tester.pumpAndSettle();

  /// Test Contact us
  await ensureWidgetIsVisible(tester, find.text(tr('contact_us')));
  await tester.tap(find.text(tr('contact_us')));
  await tester.pumpAndSettle();
  await _supportTest(tester);
}

Future<void> _supportTest(WidgetTester tester) async {
  /// fill first name text field
  await fillTextField(tester, firstNameTextFieldFinder, "hussein hamed");

  /// fill email text field
  await fillTextField(tester, emailTextFieldFinder, "test@gmail.com");

  /// fill support message text field
  await fillTextField(tester, supportMessageTextFieldFinder, "first issue");

  /// tap on send button
  await scroll(tester, sendButtonFinder, sendIssueScrollListFinder);
  await tester.pumpAndSettle();

  /// Go to home
  await tester.tap(backToHomeDialogFinder);
  await tester.pumpAndSettle();
}
