import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../helper/helper.dart';
import '../../shared/values.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("test add new gift beneficiary flow ", () {
    testWidgets('test add new gift beneficiary flow', (WidgetTester tester) async {
      // final String randomId =generateRandomNumber(10000000, 99999999).toString();
      const String randomId = "66499165";

      await giftFlow(tester, phoneNumber: "05$randomId");
    });
  });
}

Future<void> giftFlow(WidgetTester tester, {required String phoneNumber, bool withLogin = true}) async {
  await tapMoreFinder(giftFinder, tester, startFromInitApp: withLogin);
  await clickOnButton(tester, receivedGitsTapFinder);
  await clickOnButton(tester, sendGiftTapFinder);
  await clickOnButton(tester, giftAddBeneficiaryButtonFinder);

  /// enter gift title
  await fillTextField(tester, giftTitleTextFieldFinder, 'TEST ');

  /// enter recipient name
  await fillTextField(tester, recipientNameTextFieldFinder, 'TEST');

  /// enter first name
  await fillTextField(tester, firstNameTextFieldFinder, 'hussein');

  /// enter last name
  await fillTextField(tester, lastNameTextFieldFinder, 'hamed');

  /// enter phone number
  await fillTextField(tester, phoneNumberTextFieldFinder, phoneNumber);

  /// click on continue button
  await clickOnButton(tester, addGiftBeneficiaryContinueButtonFinder);
  await sendMoneyFlow(tester);
}

// Future<void> clickOnAlreadyExistGiftBeneficiaryToSendGiftToHim(WidgetTester tester) async {
//   /// click on beneficiary item
//   await clickOnButton(tester, beneficiaryItemButtonFinder);
//   /// enter amount
//   await sendMoneyFlow(tester);
// }

Future<void> sendMoneyFlow(WidgetTester tester) async {
  await fillTextField(tester, transactionAmountTextFieldFinder, '1');

  /// select category
  Finder dropdownItem = find.text('Bills').last;
  await selectFromDropDownList(tester, dropdownItem, categoriesDropDownListFinder);

  /// select purpose
  dropdownItem = find.text('Salary').last;
  await selectFromDropDownList(tester, dropdownItem, purposeDropDownListFinder);

  ///fill note field
  await fillTextField(tester, noteTextFieldFinder, 'new note');

  ///click on continue button on send gift
  await ensureWidgetIsVisible(tester, sendGiftContinueButtonFinder);
  await clickOnButton(tester, sendGiftContinueButtonFinder);
  await clickOnButton(tester, viewEReceiptFinder);
  await tester.pumpAndSettle();
  await clickOnButton(tester, closeScreenButton);
  await tester.pumpAndSettle();
}


Future<void> deepGiftFlow(WidgetTester tester, {required String phoneNumber, bool withLogin = true}) async {
  await tapMoreFinder(giftFinder, tester, startFromInitApp: withLogin);
  await clickOnButton(tester, receivedGitsTapFinder);
  await clickOnButton(tester, sendGiftTapFinder);
  await clickOnButton(tester, giftAddBeneficiaryButtonFinder);

  /// enter gift title
  await fillTextField(tester, giftTitleTextFieldFinder, 'TEST ');

  /// enter recipient name
  await fillTextField(tester, recipientNameTextFieldFinder, 'TEST');

  /// enter first name
  await fillTextField(tester, firstNameTextFieldFinder, 'hu');
  await clickOnButton(tester, addGiftBeneficiaryContinueButtonFinder);
  await fillTextField(tester, firstNameTextFieldFinder, 'hussein');
  /// enter last name
  await fillTextField(tester, lastNameTextFieldFinder, 'hamed');
  await clickOnButton(tester, addGiftBeneficiaryContinueButtonFinder);
  /// enter phone number
  await fillTextField(tester, phoneNumberTextFieldFinder, "04553345");

  await clickOnButton(tester, addGiftBeneficiaryContinueButtonFinder);

  await fillTextField(tester, phoneNumberTextFieldFinder, "0566499165");
  await clickOnButton(tester, addGiftBeneficiaryContinueButtonFinder);

  /// enter phone number
  await fillTextField(tester, phoneNumberTextFieldFinder, phoneNumber);

  /// click on continue button
  await clickOnButton(tester, addGiftBeneficiaryContinueButtonFinder);
  await sendMoneyFlow(tester);
}
