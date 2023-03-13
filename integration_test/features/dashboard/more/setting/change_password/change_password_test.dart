import 'package:flutter_test/flutter_test.dart';

import '../../../../../helper/helper.dart';
import '../../../../../shared/values.dart';
import '../../../../../start_app_test.dart';
import '../../../../authentication/authentication_flow_test.dart';
import '../../../../authentication/login/login_test.dart';

void main() {
  group('Change password test', () {
    testWidgets('Change password test', (WidgetTester tester) async {
      await startApp(tester);

      await login(tester);

      await changePasswordTest(tester);
    });
  });
}

Future<void> changePasswordTest(WidgetTester tester,)async{
  /// tap on more icon
  await tester.tap(moreIconFinder);
  await tester.pumpAndSettle();

  /// tap on settings icon
  await tester.tap(settingFinder);
  await tester.pumpAndSettle();

  /// tap on change password item
  await tester.tap(changePasswordFinder);
  await tester.pumpAndSettle();

  /// fill text fields
  await tester.enterText(oldPasswordTextFieldKeFinder, "Mobile@2022");
  await tester.pumpAndSettle();
  await tester.enterText(newPasswordTextFieldKeFinder, "Mobile@2023");
  await tester.pumpAndSettle();
  await tester.enterText(confirmNewPasswordTextFieldKeFinder, "Mobile@2023");
  await tester.pumpAndSettle();

  /// confirm change password
  await scroll(
      tester, confirmChangePasswordButtonFinder, changePasswordListFinder);

  /// back again to more screen
  await back(tester);
  await deleteSnackBar(tester);

  /// logout
  await logout(tester);

  /// login again with the new password
  await login(tester, password: "Mobile@2023");

  /// tap on more icon
  await tester.tap(moreIconFinder);
  await tester.pumpAndSettle();

  /// tap on settings icon
  await tester.tap(settingFinder);
  await tester.pumpAndSettle();

  /// tap on (change password) setting item again
  await tester.tap(changePasswordFinder);
  await tester.pumpAndSettle();

  /// fill text fields
  await tester.enterText(oldPasswordTextFieldKeFinder, "Mobile@2023");
  await tester.pumpAndSettle();
  await tester.enterText(newPasswordTextFieldKeFinder, "Mobile@2022");
  await tester.pumpAndSettle();
  await tester.enterText(confirmNewPasswordTextFieldKeFinder, "Mobile@2022");
  await tester.pumpAndSettle();

  /// confirm change password
  await scroll(
      tester, confirmChangePasswordButtonFinder, changePasswordListFinder);

  /// back again to home screen
  await back(tester);
  await deleteSnackBar(tester);

  await clickOnButton(tester, homeIconFinder);
  await tester.pumpAndSettle();
}
