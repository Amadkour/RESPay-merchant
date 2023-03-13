import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../helper/helper.dart';
import '../../shared/values.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("test add new beneficiary request flow ", () {
    testWidgets('test request view', (WidgetTester tester) async {
      const String randomId = "0510490191";
      // const String randomId = "66499165";

      await requestFlow(tester, phoneNumber: "05$randomId");
    });
  });
}

Future<void> requestFlow(WidgetTester tester, {bool withLogin = true, required String phoneNumber}) async {
  await tapMoreFinder(requestFinder, tester, startFromInitApp: withLogin);
  await clickOnButton(tester, requestAddBeneficiaryButtonFinder);

  /// enter first name
  await fillTextField(tester, firstNameTextFieldFinder, 'hussein');

  /// enter last name
  await fillTextField(tester, lastNameTextFieldFinder, 'hamed');

  /// enter phone number
  await fillTextField(tester, phoneNumberTextFieldFinder, phoneNumber);

  /// click on continue button
  await clickOnButton(tester, addRequestBeneficiaryContinueButtonFinder);
  await requestMoneyFlow(tester);
  await back(tester);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();
}

Future<void> requestMoneyFlow(WidgetTester tester) async {
  await isPresent(transactionAmountTextFieldFinder, tester);

  /// enter amount
  await fillTextField(tester, transactionAmountTextFieldFinder, '2');

  /// select category
  final Finder dropdownItem = find.text('Salary').last;
  await selectFromDropDownList(tester, dropdownItem, categoriesDropDownListFinder);

  ///fill note field
  await fillTextField(tester, noteTextFieldFinder, 'new note');

  ///click on continue button on request amount page
  await ensureWidgetIsVisible(tester, requestAmountContinueButtonFinder);
  await clickOnButton(tester, requestAmountContinueButtonFinder);
  await ensureWidgetIsVisible(tester, viewEReceiptFinder);
  await clickOnButton(tester, viewEReceiptFinder);
}

Future<void> deepRequestFlow(WidgetTester tester, {bool withLogin = true, required String phoneNumber}) async {
  await tapMoreFinder(requestFinder, tester, startFromInitApp: withLogin);
  await clickOnButton(tester, requestAddBeneficiaryButtonFinder);

  /// enter first name
  await fillTextField(tester, firstNameTextFieldFinder, 'hussein');
  await clickOnButton(tester, addRequestBeneficiaryContinueButtonFinder);
  /// enter last name
  await fillTextField(tester, lastNameTextFieldFinder, 'hamed');
  await clickOnButton(tester, addRequestBeneficiaryContinueButtonFinder);
  /// enter phone number
  await fillTextField(tester, phoneNumberTextFieldFinder, "04553345");

  await clickOnButton(tester, addRequestBeneficiaryContinueButtonFinder);

  await fillTextField(tester, phoneNumberTextFieldFinder, "0510490191");

  await clickOnButton(tester, addRequestBeneficiaryContinueButtonFinder);

  await fillTextField(tester, phoneNumberTextFieldFinder, "0555345345");

  await clickOnButton(tester, addRequestBeneficiaryContinueButtonFinder);
  /// enter phone number
  await fillTextField(tester, phoneNumberTextFieldFinder, phoneNumber);

  /// click on continue button
  await clickOnButton(tester, addRequestBeneficiaryContinueButtonFinder);
  await requestMoneyFlow(tester);
  await back(tester);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();
}
