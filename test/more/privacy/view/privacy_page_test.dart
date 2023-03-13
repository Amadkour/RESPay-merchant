import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/features/authentication/provider/model/terms_privacy_about_model.dart';
import 'package:res_pay_merchant/features/authentication/view/component/terms_privacy_item_widget.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/privacy/controller/privacy_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/privacy/view/page/privacy_page.dart';

import 'privacy_page_test.mocks.dart';


@GenerateMocks(<Type>[PrivacyCubit])
void main() {
  late MockPrivacyCubit mockPrivacyCubit;
  late final List<TermPrivacyAboutModel> privacyList =<TermPrivacyAboutModel>[
    TermPrivacyAboutModel(title: "test title",description: "test description"),
  ];
  setUp(() {
    mockPrivacyCubit = MockPrivacyCubit();
  });
  group('testing Privacy screen', () {
    testWidgets('testing Privacy view', (WidgetTester tester) async {
      when(mockPrivacyCubit.privacyModels).thenReturn(privacyList);
      await tester.pumpWidget(BlocProvider<PrivacyCubit>(
        create: (BuildContext context) => mockPrivacyCubit,
        child: MaterialApp(
          navigatorKey: globalKey,
          home: Scaffold(
            body: PrivacyPageBody(cubit: mockPrivacyCubit,),
          )
        ),
      ));
      expect(tester.widgetList(find.bySubtype<TermsPrivacyWidget>()).length, 1);
    });
  });
}
