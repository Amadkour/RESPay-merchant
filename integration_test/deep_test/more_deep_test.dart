import 'package:flutter_test/flutter_test.dart';

import '../features/FAQs/faqs_test.dart';
import '../features/authentication/login/login_test.dart';
import '../features/dashboard/home/card/card_test.dart';
import '../features/dashboard/more/about/about_test.dart';
import '../features/dashboard/more/customer_loyality/customer_loyality_test.dart';
import '../features/dashboard/more/language/language_test.dart';
import '../features/dashboard/more/privacy/privacy_test.dart';
import '../features/dashboard/more/profile/profile_test.dart';
import '../features/dashboard/more/promotions/promotions_test.dart';
import '../features/dashboard/more/referral/referral_test.dart';
import '../features/dashboard/more/setting/change_password/change_password_test.dart';
import '../features/dashboard/more/shipping_location/shipping_location_test.dart';
import '../features/dashboard/more/support/support_test.dart';
import '../features/dashboard/more/terms/terms_test.dart';
import '../features/orders/orders_test.dart';
import '../start_app_test.dart';

void main() {
  group('More deep test', () {
    testWidgets('More deep test', (WidgetTester tester) async {
      /// Start and login
      await startApp(tester);
      await login(tester);
      /// Test modules
      await changePasswordTest(tester);
      await profileDeepTest(tester);
      await ordersTest(tester);
      await cardsDeepTest(tester);
      await referralDeepTest(tester);
      await promotionDeepTest(tester);
      await customerLoyaltyDeepTest(tester);
      await shippingLocationDeepTest(tester);
      await languageTest(tester);
      await faqDeepTest(tester);
      await privacyTest(tester);
      await termsTest(tester);
      await aboutTest(tester);
      await supportFlow(tester);
    });
  });
}
