import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/features/authentication/provider/model/terms_privacy_about_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/about/controller/about_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/about/view/page/about_page.dart';


import 'about_widget_test.mocks.dart';

@GenerateMocks(<Type>[AboutCubit])
void main() {
  late MockAboutCubit mockAboutCubit;

  late final List<TermPrivacyAboutModel> privacyList =<TermPrivacyAboutModel>[
    TermPrivacyAboutModel(title: "test title",description: "test description"),
  ];
  setUp(() {
    mockAboutCubit = MockAboutCubit()..emit(AboutInitial());
  });
  group('testing about screen', () {
    testWidgets('testing about view', (WidgetTester tester) async {
      when(mockAboutCubit.aboutModels).thenReturn(privacyList);
      await tester.pumpWidget(BlocProvider<AboutCubit>(
        create: (BuildContext context) => mockAboutCubit,
        child: MaterialApp(
          navigatorKey: globalKey,
          home: Builder(builder: (BuildContext context) {
            return Scaffold(
              body: AboutScreen(cubit: mockAboutCubit,),
            );
          }),
        ),
      ));
       expect(find.text("test title"), findsOneWidget);
       expect(find.text("test description"), findsOneWidget);
    });
  });
}
