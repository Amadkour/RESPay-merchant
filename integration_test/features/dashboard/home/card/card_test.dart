import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/helper.dart';
import '../../../../shared/values.dart';
import '../../../../start_app_test.dart';
import '../../../authentication/login/login_test.dart';

void main() {
  group('Cards Test', () {
    testWidgets('Cards Test', (WidgetTester tester) async {
      await startApp(tester);
      await login(tester);
      await cardsTest(tester);
    });
  });
}

Future<void> cardsTest(WidgetTester tester) async {
  /// go to cards page
  await tester.tap(viewMoreCardsFinder);
  await tester.pumpAndSettle();

  /// add card scenario
  await _addCard(tester);

  /// delete card scenario
  await _deleteCard(tester);

  /// go to cards page
  await tester.tap(viewMoreCardsFinder);
  await tester.pumpAndSettle();

  /// add card scenario
  await _addCard(tester);

  /// back to home
  await back(tester);
  await tester.pumpAndSettle();
}

Future<void> cardsDeepTest(WidgetTester tester) async {
  await goToBottomMoreIconAndOpenItem(moreCardsFinder, tester,isLogin: true);

  /// add card scenario
  await _addCard(tester);

  /// delete card scenario
  await _deleteCard(tester);

  await tester.tap(moreCardsFinder);
  await tester.pumpAndSettle();

  /// add card scenario
  await _addCard(tester);

  /// back to home
  await back(tester);
  await tester.pumpAndSettle();
  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle();
}

Future<void> _addCard(WidgetTester tester) async {
  /// tap on add icon to go to add card page
  await tester.tap(addCardFinder);
  await tester.pumpAndSettle();

  /// fill text fields
  await addCreditCardFlow(tester);
}

Future<void> addCreditCardFlow(WidgetTester tester) async {
  /// fill text fields
  await tester.enterText(cardNumberTextFieldFinder, "5555-5555-5555-4444");
  await tester.pumpAndSettle();
  await tester.enterText(cvvTextFieldFinder, "123");
  await tester.pumpAndSettle();
  await tester.tap(dateTextFieldFinder);
  await tester.pumpAndSettle();
  // Find the default option (the first one)
  // final Finder yearFinder = find.text(DateTime.now().year.toString());
  final Finder newYearFinder = find.text((DateTime.now().year + 1).toString());
  //
  // expect(yearFinder, findsOneWidget);
  //
  // // Apply an offset to scroll
  // const Offset offset = Offset(0.0, -50.0);
  //
  // // Use both methods: fling and drag
  // await tester.fling(
  //   newYearFinder,
  //   offset,
  //   1000,
  //   warnIfMissed: false,
  // );
  //
  // await tester.drag(
  //   newYearFinder,
  //   offset,
  //   warnIfMissed: false,
  // );

  await scroll(tester, newYearFinder, yearsDateListFinder);
  // press done button to confirm the date
  await tester.tap(confirmDateFinder);
  await tester.pumpAndSettle();
  await tester.enterText(nameOnCardTextFieldFinder, "Mohamed");
  await tester.pumpAndSettle();

  /// submit add card
  await tester.tap(confirmAddCardButtonFinder);
  await tester.pumpAndSettle();
}

Future<void> _deleteCard(WidgetTester tester) async {
  await ensureWidgetIsVisible(tester, deleteCardButtonFinder);
  await tester.tap(deleteCardButtonFinder);
  await tester.pumpAndSettle();
  await tester.tap(confirmButtonDialogFinder);
  await tester.pumpAndSettle();
}
