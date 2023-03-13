import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../features/authentication/forget_password/forget_password_deep_test.dart';
import '../features/authentication/login/login_deep_test.dart';
import '../features/authentication/registration/registeration_deep_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('full authentication deep test', (WidgetTester tester) async {
    ///----registration
    await registrationDeepTest(tester);

    ///----login
    await loginDeepTest(tester, fromStart: false);

    ///----forget password

    await forgetPasswordDeepTest(tester, fromStart: false);
  });
}
