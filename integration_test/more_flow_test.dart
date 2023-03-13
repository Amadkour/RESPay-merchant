import 'package:flutter_test/flutter_test.dart';
import 'features/FAQs/faqs_test.dart';
import 'features/authentication/authentication_flow_test.dart';
import 'features/authentication/login/login_test.dart';
import 'features/dashboard/more/about/about_test.dart';
import 'features/dashboard/more/customer_loyality/customer_loyality_test.dart';
import 'features/dashboard/more/language/language_test.dart';
import 'features/dashboard/more/privacy/privacy_test.dart';

import 'features/dashboard/more/profile/profile_test.dart';
import 'features/dashboard/more/promotions/promotions_test.dart';
import 'features/dashboard/more/referral/referral_test.dart';
import 'features/dashboard/more/setting/change_password/change_password_test.dart';
import 'features/dashboard/more/shipping_location/shipping_location_test.dart';
import 'features/dashboard/more/support/support_test.dart';
import 'features/dashboard/more/terms/terms_test.dart';
import 'features/orders/orders_test.dart';
import 'start_app_test.dart';

void main() {
  group('more flow test', () {
    testWidgets('flow test.....', (WidgetTester tester) async {
      /// start app
      await startApp(tester);
      await login(tester);

      /// profile
      await profileFlow(tester, );

      /// referral
      await referralTest(tester);

      /// setting
      await changePasswordTest(tester);

      /// promotions
      await promotionsFlow(tester);

      // /// schedule call
      // await scheduleCall(tester);

      /// order
      await ordersTest(tester);

      /// customer loyalty
      await customerLoyalty(tester, isLogin: true);

      /// language
      await languageTest(tester);

      /// FAQs
      await faqTest(tester, isLogin: true);

      /// privacy
      await privacyTest(tester);

      /// terms and conditions
      await termsTest(tester);

      /// About
      await aboutTest(tester);

      /// support
      await supportFlow(tester);

      /// shipping
      await shippingLocationTest(tester);

      /// logout from the app
      await logout(tester);
    });
  });
}
