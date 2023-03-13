import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helper/helper.dart';
import '../../../../shared/values.dart';
import '../../../../start_app_test.dart';
import '../../../authentication/login/login_test.dart';

void main() {
  /// This setup for accept permission without accept it manually in UI
  group('address test', () {
    testWidgets('address test', (WidgetTester tester) async {
      await startApp(tester);

      await login(tester);

      await shippingLocationTest(tester);
    });
  });
}

Future<void> _addAddress(WidgetTester tester,
    {bool isDefaultAddress = true}) async {
  /// Go to add address page
  // await scroll(tester, addNewAddressFinder, bottomSheetListFinder);
  await ensureWidgetIsVisible(tester, addNewAddressFinder);
  await tester.tap(addNewAddressFinder);
  await tester.pumpAndSettle();

  // const MethodChannel channel =
  //     MethodChannel('plugins.flutter.io/ACCESS_COARSE_LOCATION');
  // channel.setMockMethodCallHandler((MethodCall methodCall) async {});
  // const MethodChannel channel2 =
  //     MethodChannel('plugins.flutter.io/ACCESS_FINE_LOCATION');
  // channel2.setMockMethodCallHandler((MethodCall methodCall) async {});
// final Finder finder = find.text('While using the app');
// await tester.tap(finder);
  await tester.enterText(streetNameTextFieldFinder, 'Talat Harb street');
  await tester.pumpAndSettle();
  await tester.enterText(postalCodeTextFieldFinder, '11111');
  await tester.pumpAndSettle();
  await tester.enterText(houseNumberTextFieldFinder, '27');
  await tester.pumpAndSettle();
  await tester.enterText(stateTextFieldFinder, 'Cairo');
  await tester.pumpAndSettle();
  await tester.enterText(phoneNumberTextFieldFinder, '0533333333');
  await tester.pumpAndSettle();

  final Finder dropdownItem = find.byKey(const Key("country_withId_1"));
  await selectFromDropDownList(
      tester, dropdownItem, countriesDropdownListFinder);
  await selectFromDropDownList(
      tester, firstCityFinder, citiesDropdownListFinder);

  if (isDefaultAddress) {
    await ensureWidgetIsVisible(tester, defaultAddressCheckBoxFinder);
    await tester.tap(defaultAddressCheckBoxFinder);
    await tester.pumpAndSettle();
  }

  await ensureWidgetIsVisible(tester, confirmAddAddressButtonFinder);
  await tester.tap(confirmAddAddressButtonFinder);
  await tester.pumpAndSettle();

  await tester.pumpAndSettle(const Duration(seconds: 2));
  await ensureWidgetIsVisible(tester, continueButtonAfterSelectAddressFinder);
  await clickOnButton(tester, continueButtonAfterSelectAddressFinder);
  await tester.pumpAndSettle();
}

/// Test
Future<void> shippingLocationTest(WidgetTester tester) async {
  /// Go to shipping location button sheet
  await goToBottomMoreIconAndOpenItem(shippingLocationFinder, tester,
      isLogin: true);

  await _addAddress(tester);

  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle();
}

/// Deep Test
Future<void> shippingLocationDeepTest(WidgetTester tester) async {
  await goToBottomMoreIconAndOpenItem(shippingLocationFinder, tester,
      isLogin: true);

  /// test add address as a default address
  await _addAddress(tester, isDefaultAddress: false);
  await tester.tap(shippingLocationFinder);
  await tester.pumpAndSettle();

  /// test add address which it is not a default address
  await _addAddress(tester);

  await tester.tap(shippingLocationFinder);
  await tester.pumpAndSettle();

  /// test delete address
  await tester.tap(deleteAddressFinder);
  await tester.pumpAndSettle();
  await tester.tap(confirmButtonDialogFinder);
  await tester.pumpAndSettle();

  /// test use now button
  await ensureWidgetIsVisible(tester, continueButtonAfterSelectAddressFinder);
  await tester.tap(continueButtonAfterSelectAddressFinder);
  await tester.pumpAndSettle();

  /// go to home
  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle();
}
