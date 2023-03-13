import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/features/authentication/provider/model/terms_privacy_about_model.dart';
import 'package:res_pay_merchant/features/authentication/view/component/terms_privacy_item_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/controller/terms_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/view/page/terms_and_conditions_page.dart';

import 'terms_and_conditions_test.mocks.dart';



@GenerateMocks(<Type>[TermsCubit])
void main() {
  late MockTermsCubit mockTermsCubit;
  late final List<TermPrivacyAboutModel> termsList =<TermPrivacyAboutModel>[
    TermPrivacyAboutModel(title: "test title",description: "test description"),
  ];
  setUp(() {
    mockTermsCubit = MockTermsCubit();
  });
  group('testing Terms screen', () {
    testWidgets('testing Terms view', (WidgetTester tester) async {
      when(mockTermsCubit.terms).thenReturn(termsList);
      await tester.pumpWidget(BlocProvider<TermsCubit>(
        create: (BuildContext context) => mockTermsCubit,
        child: MaterialApp(
            navigatorKey: globalKey,
            home: Scaffold(
              body: TermsAndConditionsBody(cubit: mockTermsCubit,),
            )
        ),
      ));
      expect(tester.widgetList(find.bySubtype<TermsPrivacyWidget>()).length, 1);
    });
  });
}
