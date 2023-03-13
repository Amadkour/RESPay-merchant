import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/controller/bill_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/provider/model/bill_summary.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/view/page/add_bill_request.dart';
import 'package:res_pay_merchant/features/payment/modules/pay_bill/view/page/bill_summery_page.dart';

import '../../core/global_mocks/set_up_test.dart';

void main() {
  late BillCubit cubit;

  setUpAll(() {
    mockTest();

    cubit = sl<BillCubit>();

    final Stream<BillState> stream = Stream<BillState>.fromIterable(<BillState>[
      BillDataChanged(),
      PayBillLoaded(),
      PayBillErrorState(ServerFailure()),
      PayBillLoading(),
      BillRequestLoaded(),
      BillTypesLoaded(),
      BillRequestLoading(),
      BillTypesLoading(),
      BillChangeType(),
      BillInitial(),
    ]);

    when(cubit.stream).thenAnswer((Invocation realInvocation) => stream);
    when(cubit.state).thenReturn(BillRequestLoaded());

    /// Mock data that we will use in the design
    when(cubit.billTypeModel).thenReturn('Bill');
    // when(cubit.billTypes).thenReturn(<String>['Bill']);
    when(cubit.buttonEnabled).thenReturn(false);
  });

  group('Pay bill page test', () {
    testWidgets('Pay bill page test', (WidgetTester tester) async {
      /// Pump the widget
      await tester.pumpWidget(const MaterialApp(home: AddBillRequest()));
      when(cubit.getBill()).thenAnswer((Invocation i) async => true);

      /// You'd also want to be sure that your page is now
      /// present in the screen.
      expect(find.byKey(customerIdKey), findsOneWidget);
      expect(find.byKey(seeBillKey), findsOneWidget);
      await tester.enterText(find.byKey(customerIdKey), "1111-1111-1111-1111");
      await tester.pumpAndSettle();

      expect(find.text('1111-1111-1111-1111'), findsOneWidget);
    });

    testWidgets('BillSummery page test', (WidgetTester tester) async {
      when(cubit.billSummary).thenReturn(
        BillSummaryModel(
          bill: Bill(
            total: Total(bill: '1000', fee: '100', totalBill: '1100'),
            billDetail: BillDetail(
                company: 'company',
                billingPeriod: '2 March - 3 Feb',
                customerId: '1',
                customerName: 'Mohamed'),
          ),
        ),
      );

      /// Pump the widget
      await tester.pumpWidget(
          MaterialApp(navigatorKey: globalKey, home: const BillSummery()));
      expect(find.text(tr('pay_bill')), findsOneWidget);
      expect(find.text(tr('pay_now')), findsOneWidget);
    });
  });
}
