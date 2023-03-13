import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:res_pay_merchant/features/payment/modules/withdraw/provider/model/bank_account.dart';

import '../../helper/helper.dart';
import '../../shared/values.dart';
import '../authentication/authentication_flow_test.dart';

void main() {
  group("Withdraw Flow test ", () {
    testWidgets('withdraw test', (WidgetTester tester) async {
      await withdraw(tester);
    });
  });
}

// Future<void> withdraw(WidgetTester tester, {bool withLogin = true}) async {
//   if (withLogin) {
//     await startApp(tester);
//     await login(tester);
//   }
//
//
//       await withdraw(tester);
//   }

Future<void> withdraw(WidgetTester tester) async {
  await tapMoreAfterLogin(tester, withdrawFinder);
  final Iterable<Widget> accounts =
      tester.widgetList(find.bySubtype<Radio<BankAccounts?>>());
  if (accounts.isNotEmpty) {
    await _selectAccount(tester);
  } else {
    await addBankAccount(tester);
  }

  /// Enter withdraw amount

  await isPresent(withdrawAmountText, tester);
  await tester.enterText(withdrawAmountText, '500');
  await tester.pumpAndSettle();

  /// Tap to choose bank
  await _selectAccount(tester);

  /// Tap withdraw button
  await tester.tap(withdrawButton);
  await tester.pumpAndSettle();

  await writeCode(tester);
  await tester.pumpAndSettle();
  if (tester.widgetList(viewEReceiptFinder).isNotEmpty) {
    await tester.tap(viewEReceiptFinder);
    await tester.pumpAndSettle(const Duration(seconds: 1));
  }
  await tester.tap(closeScreenButton);
  await tester.pumpAndSettle();
  await logout(tester);
}

Future<void> _selectAccount(WidgetTester tester) async {
  await tester.tap(withdrawBankCheck);
  await tester.pumpAndSettle();
}

Future<void> addBankAccount(WidgetTester tester) async {
  /// Tap to add new bank account
  await isPresent(withdrawAddNewAccountButton, tester);
  await tester.tap(withdrawAddNewAccountButton);
  await tester.pumpAndSettle();

  /// new bank account info
  /// name
  await isPresent(recipientNameTextButton, tester);
  await tester.enterText(recipientNameTextButton, 'ali');
  await tester.pumpAndSettle();

  ///bank name
  final Finder dropdownItem = find.text('Saudi National Bank').last;
  await selectFromDropDownList(
      tester, dropdownItem, bankNamesDropDownListFinder);
  await tester.pumpAndSettle();

  /// account number
  final String randomAccountNumber =
      generateRandomNumber(1000000000000000000, 1000000000000001000).toString();

  await isPresent(accountNumberTextButton, tester);
  await tester.enterText(accountNumberTextButton, randomAccountNumber);
  await tester.pumpAndSettle();

  /// iban

  final String randomiBan = generateRandomNumber(1000, 9999).toString();
  await isPresent(ibanTextFieldKeyTextButton, tester);
  await tester.enterText(
      ibanTextFieldKeyTextButton, '11223344556655443232$randomiBan');
  await tester.pumpAndSettle();

  /// Tap to add  bank account
  await isPresent(withdrawAddAccountButton, tester);
  await tester.tap(withdrawAddAccountButton);
  await tester.pumpAndSettle();
}
