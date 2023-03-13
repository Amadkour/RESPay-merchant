import 'package:flutter_test/flutter_test.dart';

import 'features/budget/budget_test.dart';
import 'features/celebrity/celebrity_test.dart';
import 'features/deposit/deposit_test.dart';
import 'features/history/history_test.dart';
import 'features/orders/orders_test.dart';

void main() {
  testWidgets('testing hady full flow', (WidgetTester tester) async {
    //---testing budget
    await budgetTest(tester);

    ///---deposit test
    await depositTest(tester, withLogin: false);

    ///--- history test
    await historyTest(tester, withLogin: false);

    ///----orders test
    await ordersTest(tester);

    ///------ celebrity flow
    await celebrityFlow(tester, withLogin: false);
  });
}
