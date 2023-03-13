import 'package:flutter_test/flutter_test.dart';

import '../features/budget/budget_test.dart';
import '../features/gift/gift_test.dart';
import '../features/history/history_test.dart';
import '../features/pay_bill/pay_bill_test.dart';
import '../features/request/request_test.dart';
import '../features/saving/saving_test.dart';
import '../features/transfer/transfer_test.dart';
import '../flows/payment_services_flow_test.dart';

void main(){

  group('Transactions deep test flow...', () {
    testWidgets('began test flow...', (WidgetTester tester) async{

      // await depositTest(tester);
      // await withdraw(tester);

      ///create second account
      final String secondAccount = await accountCreation(tester);

      ///testing transfer
      await transferFlow(tester, withLogin: false,phoneNumber: "05$secondAccount");
      ///testing gift
      await giftFlow(tester, phoneNumber: "05$secondAccount", withLogin: false);

      ///testing request
      await requestFlow(tester, phoneNumber: "05$secondAccount", withLogin: false);

      await deepPayBill(tester);
      ///--- history test
      await historyTest(tester, withLogin: false);


      ///---saving testing
      await savingTest(tester);

      ///---testing budget
      await budgetTest(tester, withLogin: false);
    });
  });
}
