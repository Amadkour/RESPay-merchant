import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/controller/customer_loyalty_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/models/customer_loyality_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/view/page/customer_loyalty_first.dart';

import 'customer_loyalty_test.mocks.dart';


@GenerateMocks(<Type>[CustomerLoyaltyCubit])
void main() {
  late MockCustomerLoyaltyCubit mockCustomerLoyaltyCubit;

  late final List<CustomerLoyaltyModel> customerLoyaltyList =<CustomerLoyaltyModel>[
    CustomerLoyaltyModel(title: "test title",description: "test description"),
    CustomerLoyaltyModel(title: "test title 2",description: "test description 2"),
  ];
  setUp(() {
    mockCustomerLoyaltyCubit = MockCustomerLoyaltyCubit();
  });
  group('testing CustomerLoyalty screen', () {
    testWidgets('testing CustomerLoyalty view', (WidgetTester tester) async {
      when(mockCustomerLoyaltyCubit.customerList).thenReturn(customerLoyaltyList);
      await tester.pumpWidget(BlocProvider<CustomerLoyaltyCubit>(
        create: (BuildContext context) => mockCustomerLoyaltyCubit,
        child: MaterialApp(
          home: Builder(builder: (BuildContext context) {
            return Scaffold(
              body: MainCustomerLoyaltyBody(controller: mockCustomerLoyaltyCubit,),
            );
          }),
        ),
      ));
      expect(tester.widgetList(find.bySubtype<SingleCustomerLoyalty>()).length, 2);
    });
  });
}
