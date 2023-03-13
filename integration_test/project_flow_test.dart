import 'package:flutter_test/flutter_test.dart';

import 'features/FAQs/faqs_test.dart';
import 'features/authentication/authentication_flow_test.dart';
import 'features/authentication/login/login_test.dart';
import 'features/budget/budget_test.dart';
import 'features/cart/cart_test.dart';
import 'features/celebrity/celebrity_test.dart';
import 'features/dashboard/home/card/card_test.dart';
import 'features/dashboard/more/about/about_test.dart';
import 'features/dashboard/more/language/language_test.dart';
import 'features/dashboard/more/privacy/privacy_test.dart';
import 'features/dashboard/more/profile/profile_test.dart';
import 'features/dashboard/more/promotions/promotions_test.dart';
import 'features/dashboard/more/referral/referral_test.dart';
import 'features/dashboard/more/setting/change_password/change_password_test.dart';
import 'features/dashboard/more/shipping_location/shipping_location_test.dart';
import 'features/dashboard/more/support/support_test.dart';
import 'features/dashboard/more/terms/terms_test.dart';
import 'features/deposit/deposit_test.dart';
import 'features/history/history_test.dart';
import 'features/orders/orders_test.dart';
import 'features/pay_bill/pay_bill_test.dart';
import 'features/request/request_test.dart';
import 'features/saving/saving_test.dart';
import 'features/transfer/transfer_test.dart';

void main() {
  group('project flow test...', () {
    testWidgets('project flow', (WidgetTester tester) async {
      await testAllTheApp(tester);
    });
  });
}

Future<void> testAllTheApp(WidgetTester tester) async {
  await _authHandle(tester);

  await celebrityFlow(tester, withLogin: false);
  await _eCommerceTest(tester);
}

Future<void> _eCommerceTest(WidgetTester tester) async {
  ///------cart flow test
  await cartFlow(tester);

  ///----orders test
  await ordersTest(tester);
}

Future<void> _moreTest(WidgetTester tester) async {
  ///--- Test shipping location
  await shippingLocationTest(tester);

  ///--- Test Profile
  await profileFlow(tester);

  ///--- Test Referral
  await referralTest(tester);

  ///--- Test Promotions
  await promotionsFlow(tester);

  // ///--- Test Customer loyalty
  // await customerLoyalty(tester);

  ///--- language Test
  await languageTest(tester);

  ///--- FAQ Test
  await faqTest(tester);

  ///--- Test About
  await aboutTest(tester);

  ///--- Test Privacy
  await privacyTest(tester);

  ///--- Test Terms and conditions
  await termsTest(tester);

  ///--- Test Support
  await supportFlow(tester);
}

Future<void> _moreBottomSheetTest(WidgetTester tester, String secondAccount) async {
  ///---deposit test
  await depositTest(tester, withLogin: false);

  /// request flow
  await requestFlow(tester, phoneNumber: "05$secondAccount", withLogin: false);

  ///--- transfer test
  await transferFlow(tester, withLogin: false, phoneNumber: "05$secondAccount");

  ///--- history test
  await historyTest(tester, withLogin: false);

  ///--- saving test
  await savingTest(tester);

  ///------pay bill test
  await payBill(tester);

  ///---testing budget
  await budgetTest(tester, withLogin: false);

  /// Errors
  // ///------withdraw test
  // await withdraw(tester);
  // /// gift flow
  // await giftFlow(tester, phoneNumber: "05$secondAccount", withLogin: false);
}

Future<void> _homeTest(WidgetTester tester, String secondAccount) async {
  ///test more bottom sheet features (saving,transfer,deposit,...etc)
  await _moreBottomSheetTest(tester, secondAccount);

  /// Cards test in home
  await cardsTest(tester);
}

Future<void> _authHandle(WidgetTester tester) async {
  final String firstAccount = await authenticationFlow(tester);
  final String secondAccount = await createNewAccount(tester);
  await logout(tester);
  await login(tester);
  await changePasswordTest(tester);
  await logout(tester);
  await login(tester, identityId: firstAccount);
  await _moreTest(tester);
  await _homeTest(tester, secondAccount);
}
