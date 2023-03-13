import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';

import '../../helper/helper.dart';
import '../../shared/values.dart';
import 'forget_password/forget_password_test.dart';
import 'login/login_test.dart';
import 'registration/regestration_test.dart';

void main() {
  group('Authentication flow test', () {
    testWidgets('Authentication flow test', (WidgetTester tester) async {
      await authenticationFlow(tester);
    });
  });
}

Future<void> logout(WidgetTester tester) async {
  await tester.tap(moreIconFinder);
  await tester.pumpAndSettle();

  await ensureWidgetIsVisible(tester, logoutButtonFinder);
  await tester.tap(logoutButtonFinder);
  await tester.pumpAndSettle();
  await tester.tap(confirmButtonDialogFinder);
  await tester.pumpAndSettle();
}

Future<String> authenticationFlow(WidgetTester tester) async {
  String id = "";
  String registerPassword = "";
  await register(tester, onSuccess: (String identityId, String password) {
    id = identityId;
    registerPassword = password;
  });
  await logout(tester);
  await login(tester, identityId: id, password: registerPassword);
  await logout(tester);
  await forgetPasswordTest(tester, identityId: id, password: "Mobile@2022");
  await logout(tester);
  // await login(tester);
  return id;
}

Future<String> createNewAccount(WidgetTester tester) async {
  String secondAccount = "";
  // await logout(tester);
  final Finder finder = find.byWidgetPredicate(
    (Widget widget) => widget is RichText && tapTextSpan(widget, tr("sign_up")),
  );
  await scroll(tester, finder, loginListFinder);
  await register(tester, onSuccess: (String identityId, String password) {
    secondAccount = identityId;
  }, startWithSignUp: false);
  return secondAccount;
}
