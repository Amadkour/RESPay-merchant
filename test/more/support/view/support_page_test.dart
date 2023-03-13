import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/controller/support_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/view/page/support_page.dart';

import 'support_page_test.mocks.dart';



@GenerateMocks(<Type>[SupportCubit])
void main() {
  late MockSupportCubit mockSupportCubit;
  setUp(() {
    mockSupportCubit = MockSupportCubit();
    when(mockSupportCubit.firstNameController).thenReturn(TextEditingController());
    when(mockSupportCubit.emailController).thenReturn(TextEditingController());
    when(mockSupportCubit.supportController).thenReturn(TextEditingController());

    when(mockSupportCubit.firstNameFocus).thenReturn(FocusNode());
    when(mockSupportCubit.emailFocus).thenReturn(FocusNode());
    when(mockSupportCubit.supportNameFocus).thenReturn(FocusNode());
  });
  group('testing Support screen', () {
    testWidgets('testing Support view', (WidgetTester tester) async {

      await tester.pumpWidget(BlocProvider<SupportCubit>(
        create: (BuildContext context) => mockSupportCubit,
        child: MaterialApp(
          navigatorKey: globalKey,
          home: Builder(builder: (BuildContext context) {
            return Scaffold(
              body: SupportFormBody(supportCubit: mockSupportCubit,state: SupportInitial(),supportValidationFormKey: GlobalKey<FormState>()),
            );
          }),
        ),
      ));
      await tester.enterText(find.byKey(firstNameTextFieldKey), "test name");
      await tester.pump();
      await tester.enterText(find.byKey(emailTextFieldKey), "test@gmail.com");
      await tester.pump();
      await tester.enterText(find.byKey(supportMessageTextFieldKey), "this is new issue");
      await tester.pump();
      expect(find.text('test name'), findsOneWidget);
      expect(find.text('test@gmail.com'), findsOneWidget);
      expect(find.text('this is new issue'), findsOneWidget);
      expect(find.byType(LoadingButton), findsOneWidget);
      expect(find.text('send'), findsOneWidget);
      expect(tester.widgetList(find.bySubtype<ParentTextField>()).length, 3);
    });
  });
}
