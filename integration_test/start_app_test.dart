import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:res_pay_merchant/core/configuration/top_level_configuration.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/main.dart' as app;

import 'helper/helper.dart';
import 'shared/values.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('start app flow', () {
    testWidgets('start app flow', (WidgetTester tester) async {
      ///start app
      await startApp(tester);
    });
  });
}

Future<void> startApp(WidgetTester tester) async {
  type = 'integration test';
  await app.main();
  await sl<LocalStorageService>().removeSession();

  await tester.pumpAndSettle();
  if (tester.any(goToLoginFinder)) {
    await isPresent(goToLoginFinder, tester);
    await tester.tap(goToLoginFinder);
  } else {
    await tester.tapAt(const Offset(100, 100));
    await isPresent(viewEReceiptFinder, tester);
    await tester.tap(viewEReceiptFinder);
  }
  await tester.pumpAndSettle();
}
