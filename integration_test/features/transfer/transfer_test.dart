import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../helper/helper.dart';
import '../../shared/values.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group(
    'transfer flow',
    () {
      testWidgets('transfer flow', (WidgetTester tester) async {

        await transferFlow(tester);
      });
    },
  );
  // group("transfer money to selected beneficiary ", () {
  //   testWidgets('test transfer money to selected beneficiary', (WidgetTester tester) async {
  //     try{
  //       await continueFlowWhenClickOnSpecificBeneficiary(tester,isLocal: true);
  //     }catch(e){
  //       await externalResApp(tester);
  //     }
  //   });
  // });
}

///res app method
Future<void> externalResApp(WidgetTester tester) async {
  await chooseTransferType(tester, resAppTransferTypeFromBottomSheetFinder);

  /// choose country
  await selectFromDropDownList(
    tester,
    countryItemInCountriesDropdownListFinder,
    countriesDropdownListFinder,
  );

  /// choose currency
  await selectFromDropDownList(
    tester,
    currencyItemInCurrenciesDropdownListFinder,
    currenciesDropdownListFinder,
  );

  /// enter first name
  await fillTextField(tester, firstNameTextFieldFinder, 'hussein');

  /// enter last name
  await fillTextField(tester, lastNameTextFieldFinder, 'hamed');

  /// choose relation type
  await selectFromDropDownList(tester, relationShipItemInDropdownListFinder, relationShipsDropdownListFinder);

  /// enter phone number
  await fillTextField(tester, phoneNumberTextFieldFinder, '05${generateRandomNumber(10000000, 99999999)}');

  /// tap on the loading add beneficiary button
  await tapOnAddBeneficiaryButtonThenTapOnContinue(tester);
}

Future<void> internalResApp(WidgetTester tester,String phoneNumber) async {
  await chooseTransferType(tester, resAppInternalTransferTypeFromBottomSheetFinder);

  /// enter first name
  await fillTextField(tester, firstNameTextFieldFinder, 'hussein');

  /// enter last name
  await fillTextField(tester, lastNameTextFieldFinder, 'hamed');

  /// enter phone number
  await fillTextField(tester, phoneNumberTextFieldFinder, phoneNumber);

  /// tap on the loading add beneficiary button
  await tapOnAddBeneficiaryButtonThenTapOnContinue(tester, isLocal: true);
}


Future<void> internalGift(WidgetTester tester,String phoneNumber) async {
  await chooseTransferType(tester, resAppInternalTransferTypeFromBottomSheetFinder);

  /// enter first name
  await fillTextField(tester, firstNameTextFieldFinder, 'hussein');

  /// enter last name
  await fillTextField(tester, lastNameTextFieldFinder, 'hamed');

  /// enter phone number
  await fillTextField(tester, phoneNumberTextFieldFinder, phoneNumber);

  /// tap on the loading add beneficiary button
  await tapOnAddBeneficiaryButtonThenTapOnContinue(tester, isLocal: true);
}

//----------------------------------------------------------------------------------------------------------//

/// western union method
Future<void> externalWesternUnion(WidgetTester tester) async {
  /// start app
  await chooseTransferType(tester, westernTransferTypeFromBottomSheetFinder);

  /// choose country type
  await selectFromDropDownList(tester, countryItemInCountriesDropdownListFinder, countriesDropdownListFinder);

  /// choose currency
  await selectFromDropDownList(tester, currencyItemInCurrenciesDropdownListFinder, currenciesDropdownListFinder);

  /// enter first name
  await fillTextField(tester, firstNameTextFieldFinder, 'hussein');

  /// enter last name
  await fillTextField(tester, lastNameTextFieldFinder, 'hamed');

  /// choose relation type
  await selectFromDropDownList(tester, relationShipItemInDropdownListFinder, relationShipsDropdownListFinder);

  /// enter account number
  await fillTextField(tester, accountNumberTextFieldFinder,
      '${generateRandomNumber(1000, 9999)}-${generateRandomNumber(1000, 9999)}-${generateRandomNumber(1000, 9999)}-${generateRandomNumber(1000, 9999)}');

  /// tap on the loading add beneficiary button
  await tapOnAddBeneficiaryButtonThenTapOnContinue(tester);
}

//----------------------------------------------------------------------------------------------------------//

/// e-wallet method
Future<void> externalEWallet(WidgetTester tester) async {
  /// start app
  await chooseTransferType(tester, eWalletTypeFromBottomSheetFinder);

  /// choose country
  await selectFromDropDownList(tester, countryItemInCountriesDropdownListFinder, countriesDropdownListFinder);

  /// choose currency
  await selectFromDropDownList(tester, currencyItemInCurrenciesDropdownListFinder, currenciesDropdownListFinder);

  /// choose wallet name
  final Finder dropdownItem = find.text('Fawry').last;
  await selectFromDropDownList(tester, dropdownItem, walletNamesDropDownListFinder);

  /// enter swift code
  await fillTextField(tester, swiftCodeTextFieldFinder, '${generateRandomNumber(10000000, 99999999)}');

  /// choose nationality name
  await selectFromDropDownList(tester, nationalityItemInCurrenciesDropdownListFinder, nationalityDropDownListFinder);

  /// enter first name
  await fillTextField(tester, firstNameTextFieldFinder, 'hussein');

  /// enter last name
  await fillTextField(tester, lastNameTextFieldFinder, 'hamed');

  /// choose relation type
  await selectFromDropDownList(tester, relationShipItemInDropdownListFinder, relationShipsDropdownListFinder);

  /// enter account number
  await fillTextField(tester, accountNumberTextFieldFinder,
      '${generateRandomNumber(1000, 9999)}-${generateRandomNumber(1000, 9999)}-${generateRandomNumber(1000, 9999)}-${generateRandomNumber(1000, 9999)}');

  /// tap on the loading add beneficiary button
  await tapOnAddBeneficiaryButtonThenTapOnContinue(tester);
}

Future<void> internalEWallet(WidgetTester tester) async {
  /// start app
  await chooseTransferType(tester, eWalletInternalTypeFromBottomSheetFinder);

  /// enter first name
  await fillTextField(tester, firstNameTextFieldFinder, 'hussein');

  /// enter last name
  await fillTextField(tester, lastNameTextFieldFinder, 'hamed');

  /// enter phone number
  await fillTextField(tester, phoneNumberTextFieldFinder, '05${generateRandomNumber(10000000, 99999999)}');

  /// tap on the loading add beneficiary button
  await tapOnAddBeneficiaryButtonThenTapOnContinue(tester, isLocal: true);
}

//----------------------------------------------------------------------------------------------------------//

/// bank account method
Future<void> externalBankAccount(WidgetTester tester) async {
  await chooseTransferType(tester, bankAccountTypeFromBottomSheetFinder);

  await tester.pumpAndSettle();
  /// choose country
  await selectFromDropDownList(
    tester,
    countryItemInCountriesDropdownListFinder,
    countriesDropdownListFinder,
  );

  /// choose currency
  await selectFromDropDownList(
    tester,
    currencyItemInCurrenciesDropdownListFinder,
    currenciesDropdownListFinder,
  );

  /// choose bank name
  final Finder dropdownItem = find.text('Saudi National Bank').last;
  await selectFromDropDownList(tester, dropdownItem, bankNamesDropDownListFinder);

  /// enter swift code
  await fillTextField(tester, swiftCodeTextFieldFinder, '${generateRandomNumber(10000000, 99999999)}');

  /// choose nationality name
  await selectFromDropDownList(tester, nationalityItemInCurrenciesDropdownListFinder, nationalityDropDownListFinder);

  /// enter first name
  await fillTextField(tester, firstNameTextFieldFinder, 'hussein');

  /// enter last name
  await fillTextField(tester, lastNameTextFieldFinder, 'hamed');

  /// choose relation type
  await selectFromDropDownList(tester, relationShipItemInDropdownListFinder, relationShipsDropdownListFinder);

  /// enter account number
  await fillTextField(tester, accountNumberTextFieldFinder,
      '${generateRandomNumber(1000, 9999)}-${generateRandomNumber(1000, 9999)}-${generateRandomNumber(1000, 9999)}-${generateRandomNumber(1000, 9999)}');

  /// enter IBAN number
  await fillTextField(
      tester,
      iBANTextFieldFinder,
      '${generateRandomNumber(1000, 9999)}${generateRandomNumber(1000, 9999)}${generateRandomNumber(1000, 9999)}${generateRandomNumber(1000, 9999)}' *
          2);

  /// tap on the loading add beneficiary button
  await tapOnAddBeneficiaryButtonThenTapOnContinue(tester);
}

Future<void> internalBankAccount(WidgetTester tester) async {
  /// start app
  await chooseTransferType(tester, bankAccountInternalTypeFromBottomSheetFinder);

  /// enter first name
  await fillTextField(tester, firstNameTextFieldFinder, 'hussein');

  /// enter last name
  await fillTextField(tester, lastNameTextFieldFinder, 'hamed');

  /// choose bank name
  final Finder dropdownItem = find.text('Saudi National Bank').last;
  await selectFromDropDownList(tester, dropdownItem, bankNamesDropDownListFinder);

  /// enter account number
  await fillTextField(tester, accountNumberTextFieldFinder,
      '${generateRandomNumber(1000, 9999)}-${generateRandomNumber(1000, 9999)}-${generateRandomNumber(1000, 9999)}-${generateRandomNumber(1000, 9999)}');

  /// enter IBAN number
  await fillTextField(
      tester,
      iBANTextFieldFinder,
      '${generateRandomNumber(1000, 9999)}${generateRandomNumber(1000, 9999)}${generateRandomNumber(1000, 9999)}${generateRandomNumber(1000, 9999)}' *
          2);

  /// tap on the loading add beneficiary button
  await tapOnAddBeneficiaryButtonThenTapOnContinue(tester, isLocal: true);
}

//----------------------------------------------------------------------------------------------------------//

///helper methods
Future<void> selectTransferTypeFromList(WidgetTester tester, Finder targetTransferTypeItem) async {
  await clickOnButton(tester, transferAddBeneficiaryButtonFinder);
  await ensureWidgetIsVisible(tester, targetTransferTypeItem);
  await clickOnButton(tester, targetTransferTypeItem);
}

Future<void> chooseTransferType(WidgetTester tester, Finder targetTransferTypeItem) async {
  /// click on add new beneficiary button to open transfer
  await selectTransferTypeFromList(tester, targetTransferTypeItem);
}

Future<void> tapOnAddBeneficiaryButtonThenTapOnContinue(WidgetTester tester, {bool isLocal = false}) async {
  /// tap on the loading add beneficiary button
  await clickOnButton(tester, transferDetailsLoadingButtonFinder);

  /// tap on the loading continue button
  await clickOnButton(tester, continueLoadingButtonFinder);
  await clickOnButton(tester, callMeNowButtonFinder);
  await clickOnButton(tester, makeTransferButtonFinder);
  await continueFlowWhenClickOnSpecificBeneficiary(tester, isLocal: isLocal);
}

Future<void> continueFlowWhenClickOnSpecificBeneficiary(WidgetTester tester, {bool isLocal = false}) async {
  /// fill amount field
  await fillTextField(tester, transactionAmountTextFieldFinder, '1');
  if (isLocal) {
    /// select category
    final Finder dropdownItem = find.text('Bills').last;
    await selectFromDropDownList(tester, dropdownItem, categoriesDropDownListFinder);

    ///fill note field
    await fillTextField(tester, noteTextFieldFinder, 'new note');
  }

  /// select purpose
  final Finder dropdownItem = find.text('Salary').last;
  await selectFromDropDownList(tester, dropdownItem, purposeDropDownListFinder);
  await clickOnButton(tester, makeTransferContinueButtonFinder);
  await ensureWidgetIsVisible(tester, newTransferSummaryConfirmButtonFinder);
  await clickOnButton(tester, newTransferSummaryConfirmButtonFinder);
  await writeCode(tester);
  await tester.pumpAndSettle();
  await waitUntilVisible(tester, viewEReceiptFinder);
  await clickOnButton(tester, viewEReceiptFinder);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await clickOnButton(tester, closeScreenButton);
}

Future<void> transferFlow(WidgetTester tester, {bool withLogin = true,String ?phoneNumber}) async {

  /// test international mobile wallet flow
  await goToMoreAndChooseTransfer(tester, withLogin: withLogin);
  await externalEWallet(tester);


  /// test international bank account flow
  await goToMoreAndChooseTransfer(tester, withLogin: withLogin);
  await externalBankAccount(tester);


  /// test international RES App flow
  await goToMoreAndChooseTransfer(tester, withLogin: withLogin);
  await externalResApp(tester);

  /// test local RES App flow
  await goToMoreAndChooseTransfer(tester, withLogin: withLogin);
  await internalResApp(tester,phoneNumber!);

  /// test international western union flow
  await goToMoreAndChooseTransfer(tester, withLogin: withLogin);
  await externalWesternUnion(tester);

  /// test local bank account flow (return bank account not found)
  // await goToMoreAndChooseTransfer(tester, withLogin: withLogin);
  // await internalBankAccount(tester);

  /// test local mobile mobile wallet flow (return The receiver wallet does not exist! )
  // await goToMoreAndChooseTransfer(tester, withLogin: withLogin);
  // await internalEWallet(tester);

}

Future<void> goToMoreAndChooseTransfer(WidgetTester tester, {bool withLogin=true}) async {
   await tapMoreFinder(transferFinder, tester, startFromInitApp: withLogin);
  await tester.pumpAndSettle();
}
