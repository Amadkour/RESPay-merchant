import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
import '../../helper/helper.dart';
import '../../shared/values.dart';
import '../../start_app_test.dart';
import '../authentication/login/login_test.dart';
import '../dashboard/home/card/card_test.dart';

void main() {
  testWidgets("deposit flow testing", (WidgetTester tester) async {
    await depositTest(tester);
  });
}

Future<void> depositTest(WidgetTester tester, {bool withLogin = true}) async {
  if (withLogin) {
    await startApp(tester);
    await login(tester);
  }
  // testing open deposit screen from deposit icon directly
  await _openDepositFromWalletCardIcon(tester);
  await back(tester);
  await tester.pumpAndSettle();

  /// testing open deposit screen from transaction types sheet

  await tapMoreFinder(
    depositFinder.last,
    tester,
    startFromInitApp: false,
  );

  await _createDeposit(tester);
  // continue to receipt screen scenario
  await _receiptFlow(tester);
  // test user pressed cancel button scenario
  await _openDepositFromWalletCardIcon(tester);
  await _createDeposit(tester, createCard: false);
  await tester.tap(cancelButtonDialogFinder);
  await tester.pumpAndSettle();
}

Future<void> _receiptFlow(WidgetTester tester) async {
  await isPresent(viewEReceiptFinder, tester);
  await tester.tap(viewEReceiptFinder);
  await tester.pumpAndSettle();

  //share pdf you must
  await tester.tap(getPdfButtonFinder);
  await tester.pumpAndSettle(const Duration(seconds: 5));

  //share image and close sharing sheet
  await tester.tap(getImageButtonFinder);
  await tester.pumpAndSettle(const Duration(seconds: 5));

  //tap on download button
  await scroll(tester, openDownloadReceiptSheetFinder, find.byType(SingleChildScrollView).first);
  await tester.pumpAndSettle();
  //download pdf
  await tester.tap(getPdfButtonFinder.last);
  await tester.pumpAndSettle();
  //download image
  await scroll(tester, openDownloadReceiptSheetFinder, find.byType(SingleChildScrollView).first);
  await tester.tap(getImageButtonFinder.last);
  await tester.pumpAndSettle();
  await tester.tap(closeScreenButton);
  await tester.pumpAndSettle();
}

Future<void> _createDeposit(WidgetTester tester, {bool createCard = true}) async {
  //enter amount of deposit
  await tester.enterText(amountTextfieldFinder, "100");
  await tester.pumpAndSettle();
  //Tap on to choose credit card
  await tester.tap(chooseDepositCardButtonFinder);
  await tester.pumpAndSettle();
  if (createCard) {
    await _createCard(tester);
  }
  await _chooseLatestCard(tester);

  await tester.tap(depositSubmitButtonFinder);

  await tester.pumpAndSettle();

  await writeCode(tester);

  await tester.pumpAndSettle();
}

Future<void> _createCard(WidgetTester tester) async {
  if (tester.widgetList(find.bySubtype<Radio<CreditCardModel?>>()).isEmpty) {
    await scroll(tester, addNewCreditCardKeyButtonFinder, depositViaScrollViewFinder);
    await tester.pumpAndSettle();
    await addCreditCardFlow(tester);
  }
}

Future<void> _chooseLatestCard(WidgetTester tester) async {
  await isPresent(find.bySubtype<Radio<CreditCardModel?>>(), tester);
  await scroll(tester, find.bySubtype<Radio<CreditCardModel?>>().last, depositViaScrollViewFinder);
  await tester.pumpAndSettle();
}

Future<void> _openDepositFromWalletCardIcon(WidgetTester tester) async {
  await tester.tap(depositFinder);
  await tester.pumpAndSettle();
}
