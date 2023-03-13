import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../features/authentication/authentication_flow_test.dart';
import '../features/authentication/login/login_test.dart';
import '../features/budget/budget_test.dart';
import '../features/deposit/deposit_test.dart';
import '../features/gift/gift_test.dart';
import '../features/history/history_test.dart';
import '../features/pay_bill/pay_bill_test.dart';
import '../features/request/request_test.dart';
import '../features/saving/saving_test.dart';
import '../features/transfer/transfer_test.dart';
import '../features/withdraw/withdraw_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('testing payment flow', (WidgetTester tester) async {
    ///---deposit test
    await depositTest(tester);

    ///---create second account
    await withdraw(tester);

    ///---testing transfer
    await transferFlow(tester);
    final String secondAccount = await accountCreation(tester);

    ///---testing gift
    await giftFlow(tester, phoneNumber: "05$secondAccount", withLogin: false);

    ///---testing request
    await requestFlow(tester, phoneNumber: "05$secondAccount", withLogin: false);

    ///---testing withdraw
    await withdraw(tester);

    ///--- history test
    await historyTest(tester, withLogin: false);

    await payBill(tester);

    ///---saving testing
    await savingTest(tester);

    ///---testing budget
    await budgetTest(tester, withLogin: false);

    await logout(tester);
  });
}

Future<String> accountCreation(WidgetTester tester) async {
  await logout(tester);
  final String secondAccount = await createNewAccount(tester);
  await logout(tester);
  await login(tester);
  return secondAccount;
}
