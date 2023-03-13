import 'package:flutter_test/flutter_test.dart';

import '../../helper/helper.dart';
import '../../shared/values.dart';
import '../../start_app_test.dart';
import '../authentication/login/login_test.dart';

void main() async {
  group('Saving test', () {
    testWidgets('Saving test', (WidgetTester tester) async {
      await startApp(tester);
      await login(tester);

      /// go to saving page
      await savingTest(tester);
    });
  });
}

Future<void> savingTest(WidgetTester tester) async {
  await tapMoreAfterLogin(tester, savingFinder);

  /// Test roles
  await _roleTesting(tester);

  /// Transaction test
  await _transactionsTest(tester);

  /// Test Saving Activate/Deactivate
  await _testSavingDeactivate(tester);

  /// back to home
  await back(tester);
  await tester.pumpAndSettle(const Duration(seconds: 2));

}

///----------------------- Roles Test ------------------------ ///
Future<void> _roleTesting(WidgetTester tester) async {
  /// Test add role
  await _addNewRole(tester);

  /// Test update role
  await _updateRole(tester);

  /// Test toggle role
  await _toggleRole(tester);

  /// Test delete role
  await _deleteRole(tester);
}

Future<void> _addNewRole(WidgetTester tester) async {
  /// tap add new role button
  await tester.tap(addNewRoleButtonFinder);
  await tester.pumpAndSettle();

  /// Enter textFields data
  await tester.enterText(fromTextFieldSavingFinder, '1');
  await tester.pumpAndSettle();
  await tester.enterText(toTextFieldSavingFinder, '1000');
  await tester.pumpAndSettle();
  await tester.enterText(saveTextFieldSavingFinder, '15');
  await tester.pumpAndSettle();

  /// scroll and tap on confirm button
  await scroll(tester, savingLoadingButtonFinder, savingBottomSheetListFinder);
}

Future<void> _updateRole(WidgetTester tester) async {
  /// tap on popup menu for the first role
  await tester.tap(popupRoleSavingFinder);
  await tester.pumpAndSettle();

  /// tap on delete button
  await tester.tap(updateRoleButtonFinder);
  await tester.pumpAndSettle();

  /// Enter textFields data
  await tester.enterText(fromTextFieldSavingFinder, '');
  await tester.pumpAndSettle();
  await tester.enterText(fromTextFieldSavingFinder, '5');
  await tester.pumpAndSettle();
  await tester.enterText(toTextFieldSavingFinder, '');
  await tester.pumpAndSettle();
  await tester.enterText(toTextFieldSavingFinder, '500');
  await tester.pumpAndSettle();
  await tester.enterText(saveTextFieldSavingFinder, '');
  await tester.pumpAndSettle();
  await tester.enterText(saveTextFieldSavingFinder, '25');
  await tester.pumpAndSettle();

  /// scroll and tap on confirm button
  await scroll(tester, savingLoadingButtonFinder, savingBottomSheetListFinder);
}

Future<void> _toggleRole(WidgetTester tester) async {
  /// tap on popup menu for the first role
  await tester.tap(popupRoleSavingFinder);
  await tester.pumpAndSettle();

  /// tap on delete button
  await tester.tap(toggleRoleButtonFinder);
  await tester.pumpAndSettle();
}

Future<void> _deleteRole(WidgetTester tester) async {
  /// tap on popup menu for the first role
  await tester.tap(popupRoleSavingFinder);
  await tester.pumpAndSettle(const Duration(seconds: 1));

  /// tap on delete button
  await tester.tap(deleteRoleButtonFinder);
  await tester.pumpAndSettle();

  /// tap on confirm button in dialog to confirm delete role
  await tester.tap(confirmButtonDialogFinder);
  await tester.pumpAndSettle(const Duration(seconds: 2));
}

///----------------------- Transaction Test ------------------------ ///
Future<void> _transactionsTest(WidgetTester tester) async {
  /// Test deposit money
  await _deposit(tester);

  /// Test investing money
  await _investing(tester);

  /// Test withdraw money
  await _withdraw(tester);

  /// Test viewAllTransactions
  await viewAllTransactions(tester);
}

Future<void> _deposit(WidgetTester tester) async {
  await scroll(tester, depositSavingFinder, savingListFinder);

  await tester.enterText(amountSavingTextFieldFinder, '20');
  await tester.pumpAndSettle();

  /// scroll and tap on confirm button
  await scroll(tester, savingLoadingButtonFinder, savingBottomSheetListFinder);
  await tester.pumpAndSettle(const Duration(seconds: 2));
}

Future<void> _withdraw(WidgetTester tester) async {
  await scroll(tester, withdrawSavingFinder, savingListFinder);

  await tester.enterText(amountSavingTextFieldFinder, '20');
  await tester.pumpAndSettle();

  /// scroll and tap on confirm button
  await scroll(tester, savingLoadingButtonFinder, savingBottomSheetListFinder);
  await tester.pumpAndSettle(const Duration(seconds: 2));
}

Future<void> _investing(WidgetTester tester) async {
  await scroll(tester, investingSavingFinder, savingListFinder);
  await back(tester);
  await tester.pumpAndSettle(const Duration(seconds: 2));
}

Future<void> viewAllTransactions(WidgetTester tester) async {
  await scroll(tester, blueTextFinder, savingListFinder);
  await back(tester);
}

/// ------------------------ Saving deactivation -------------------- ///
Future<void> _testSavingDeactivate(WidgetTester tester) async {
  await scroll(tester, activationToggleFinder, savingListFinder,
      scrollDown: false);
  await tester.tap(confirmButtonDialogFinder);
  await tester.pumpAndSettle();
  await scroll(tester, depositSavingFinder, savingListFinder);
  await tester.tap(confirmButtonDialogFinder);
  await tester.pumpAndSettle();
  await scroll(tester, depositSavingFinder, savingListFinder);
  await back(tester);
  await tester.pumpAndSettle();

}
