import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/controller/create_new_password/create_new_password_cubit.dart';

import 'foget_ui_test.mocks.dart';



@GenerateMocks(<Type>[
  CreateNewPasswordCubit,])
void main() {
  late MockCreateNewPasswordCubit mockCreateNewPasswordCubit;


  setUp(() {
    mockCreateNewPasswordCubit = MockCreateNewPasswordCubit();
  });
  // group('testing CustomerLoyalty screen', () {
  //   testWidgets('testing CustomerLoyalty view', (WidgetTester tester) async {
  //       create: (BuildContext context) => mockCustomerLoyaltyCubit,
  //       child: MaterialApp(
  //         home: Builder(builder: (BuildContext context) {
  //           return Scaffold(
  //             body: MainCustomerLoyaltyBody(controller: mockCustomerLoyaltyCubit,),
  //           );
  //         }),
  //       ),
  //     ));
  //     expect(tester.widgetList(find.bySubtype<SingleCustomerLoyalty>()).length, 2);
  //   });
  }
