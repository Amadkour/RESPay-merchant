import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../../helper/helper.dart';
import '../../shared/values.dart';
import '../../start_app_test.dart';
import '../authentication/login/login_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("test cart flow", () {
    testWidgets('test cart flow', (WidgetTester tester) async {
      await startApp(tester);
      await login(tester);
      await cartFlow(tester);
    });
  });
}

Future<void> cartFlow(WidgetTester tester) async {

  await tester.tap(shopIconFinder);
  await tester.pumpAndSettle();
  await scroll(tester, shopItemFinder, shopScrollFinder);
  await tester.ensureVisible(favouriteIconProductItemFinder);
  await clickOnButton(tester, favouriteIconProductItemFinder);
  await tester.ensureVisible(firstProductItemFinder);
  await clickOnButton(tester, firstProductItemFinder);
  await clickOnButton(tester, addToCartFinder);
  await clickOnButton(tester, cartIconInAppBarFinder);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await clickOnButton(tester, incrementButtonInCartListFinder);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await clickOnButton(tester, decrementButtonInCartListFinder);
  await clickOnButton(tester, showSummaryBottomSheetFinder);
  await clickOnButton(tester, checkOutNowButtonFinder);
  await clickOnButton(tester, blueTextFinder.first);
  await scroll(tester, continueButtonAfterSelectAddressFinder, selectAddressListFinder);
  await clickOnButton(tester, checkOutNowButtonFinder);
  await clickOnButton(tester,confirmButtonDialogFinder );
  await tester.pumpAndSettle();
  await tester.tap(moreIconFinder);
  await tester.pumpAndSettle();

}

Future<void> deepCartFlow(WidgetTester tester) async {

  await tester.tap(shopIconFinder);
  await tester.pumpAndSettle();
  await scroll(tester, shopItemFinder, shopScrollFinder);
  await tester.ensureVisible(favouriteIconProductItemFinder);
  await clickOnButton(tester, favouriteIconProductItemFinder);
  await tester.ensureVisible(firstProductItemFinder);
  await clickOnButton(tester, firstProductItemFinder);
  await clickOnButton(tester, addToCartFinder);
  await clickOnButton(tester, cartIconInAppBarFinder);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await clickOnButton(tester, favouriteIconInAppBarFinder);
  await back(tester);
  await tester.pumpAndSettle();
  await fillTextField(tester, storeDetailSearchProductsFinder, "new");
  await fillTextField(tester, storeDetailSearchProductsFinder, "");
  await clickOnButton(tester, firstProductItemFinder);
  await clickOnButton(tester, cartIconInAppBarFinder);
  await clickOnButton(tester, incrementButtonInCartListFinder);
  await tester.pumpAndSettle(const Duration(seconds: 1));
  await clickOnButton(tester, decrementButtonInCartListFinder);
  await clickOnButton(tester, checkOrRemovePromoCodeButtonFinder);
  await clickOnButton(tester, showSummaryBottomSheetFinder);
  await clickOnButton(tester, checkOutNowButtonFinder);
  await clickOnButton(tester, blueTextFinder.first);
  await scroll(tester, continueButtonAfterSelectAddressFinder, selectAddressListFinder);
  await clickOnButton(tester, checkOutNowButtonFinder);
  await clickOnButton(tester,confirmButtonDialogFinder );
  await tester.pumpAndSettle();
  await tester.tap(moreIconFinder);
  await tester.pumpAndSettle();

}
