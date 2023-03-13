import 'package:flutter_test/flutter_test.dart';

import '../features/authentication/authentication_flow_test.dart';
import '../features/authentication/login/login_test.dart';
import '../features/cart/cart_test.dart';
import '../features/celebrity/celebrity_test.dart';
import '../features/orders/orders_test.dart';
import '../features/shop/shop_test.dart';
import '../start_app_test.dart';

void main() {
  testWidgets('testing ecommerce deep flow', (WidgetTester tester) async {
    await startApp(tester);
    await login(tester);
    await shopFlow(tester);
    await deepCelebrityFlow(tester, withLogin: false);
    await cartFlow(tester);
    await ordersTest(tester);
    await logout(tester);
  });
}
