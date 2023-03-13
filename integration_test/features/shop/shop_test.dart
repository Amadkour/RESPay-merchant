import 'package:flutter_test/flutter_test.dart';

import '../../helper/helper.dart';
import '../../shared/values.dart';
import '../../start_app_test.dart';
import '../authentication/login/login_test.dart';

void main(){
  group('shop flow test.....', () {
    testWidgets('shop test', (WidgetTester tester) async {

      await startApp(tester);
      await login(tester);
      await shopFlow(tester);
    });
  });
}

Future<void> shopFlow(WidgetTester tester) async {
  await tester.pumpAndSettle();
  await tester.tap(shopIconFinder);
  await tester.pumpAndSettle();
  await tester.tap(shopCategoryFinder);
  await tester.pumpAndSettle();
  await tester.tap(firstShopCategoryFinder);
  await tester.pumpAndSettle();
  await tester.tap(shopItemFinder);
  await tester.pumpAndSettle();
  await back(tester);
  await tester.pumpAndSettle();
  await tester.tap(homeIconFinder);
  await tester.pumpAndSettle(const Duration(seconds: 3));
}
