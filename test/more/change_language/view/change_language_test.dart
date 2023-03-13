import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/constant/widget_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/navigation.dart';
import 'package:res_pay_merchant/core/widget/button/loading_button.dart';
import 'package:res_pay_merchant/core/widget/message.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/controller/language_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/provider/model/language_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/view/component/language_row_widget.dart';

import 'change_language_test.mocks.dart';

@GenerateMocks(<Type>[LanguageCubit])
void main() {
  late MockLanguageCubit mockLanguageCubit;
  setUp(() {
    mockLanguageCubit = MockLanguageCubit();
    when(mockLanguageCubit.state).thenReturn(LanguageInitial());
    when(mockLanguageCubit.languageModels).thenReturn(<LanguageModel>[
      LanguageModel(name: "english", locale: "en"),
      LanguageModel(name: "arabic", locale: "ar")
    ]);
  });
  group('testing Language screen', () {
    testWidgets('testing English Language is Selected',
        (WidgetTester tester) async {
      when(mockLanguageCubit.radioGroupValue).thenReturn("en_US");

      await tester.pumpWidget(BlocProvider<LanguageCubit>(
        create: (BuildContext context) => mockLanguageCubit,
        child: MaterialApp(
          navigatorKey: globalKey,
          home: Builder(builder: (BuildContext context) {
            return Scaffold(
              body: LanguageRowWidget(
                  radioKey: englishRadioButtonKey,
                  imageUrl: 'assets/icons/login/english.png',
                  title: tr(
                      mockLanguageCubit.languageModels[1].name!.toLowerCase()),
                  value: 'en_US',
                  groupValue: mockLanguageCubit.radioGroupValue,
                  toggleLanguage: mockLanguageCubit.toggleLanguage),
            );
          }),
        ),
      ));
      final Finder radioButton = find.byType(Radio<String>);
      expect(tester.widget<Radio<String>>(radioButton).value, "en_US");
    });

    testWidgets('testing Arabic Language is Selected',
        (WidgetTester tester) async {
      when(mockLanguageCubit.radioGroupValue).thenReturn("ar_AE");
      await tester.pumpWidget(BlocProvider<LanguageCubit>(
        create: (BuildContext context) => mockLanguageCubit,
        child: MaterialApp(
          navigatorKey: globalKey,
          home: Builder(builder: (BuildContext context) {
            return Scaffold(
              body: LanguageRowWidget(
                  radioKey: arabicRadioButtonKey,
                  imageUrl: 'assets/images/flags/Saudi-Arabia-Flag-icon.png',
                  title: tr(
                      mockLanguageCubit.languageModels[0].name!.toLowerCase()),
                  value: 'ar_AE',
                  groupValue: mockLanguageCubit.radioGroupValue,
                  toggleLanguage: mockLanguageCubit.toggleLanguage),
            );
          }),
        ),
      ));
      final Finder radioButton = find.byType(Radio<String>);
      expect(tester.widget<Radio<String>>(radioButton).value, "ar_AE");
    });

    testWidgets('testing change Now Button', (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider<LanguageCubit>(
        create: (BuildContext context) => mockLanguageCubit,
        child: MaterialApp(
          navigatorKey: globalKey,
          home: Builder(builder: (BuildContext context) {
            return Scaffold(
                body: LoadingButton(
              key: changeLanguageConfirmButtonKey,
              isLoading:
                  mockLanguageCubit.state is LanguageChangeLanguageLoading,
              title: tr('change_now'),
              onTap: () async {
                final String message = await mockLanguageCubit.onTapButton();
                if (message.isNotEmpty) {
                  CustomNavigator.instance.pop();
                  MyToast(
                    message,
                  );
                }
              },
            ));
          }),
        ),
      ));
      expect(find.text(tr('change_now')), findsOneWidget);
    });
  });
}
