import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/constant/shared_orefrences_keys.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/widget/text_field/design/parent/parent.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/controllers/faq_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/provider/model/faq_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/view/component/faq_card.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/view/page/faq_page.dart';

import 'faq_page_test.mocks.dart';

@GenerateMocks(<Type>[FaqCubit])
void main() {
  late MockFaqCubit mockFaqCubit;
  final List<Faqs> faqsList = <Faqs>[
    Faqs(answer: "test answer 2", question: "test question 2", subFaqs: <Faqs>[
      Faqs(
          subFaqs: <Faqs>[],
          answer: "test answer",
          question: "test question",
          uuid: "123",
          id: 1)
    ])
  ];
  setUp(() {
    mockFaqCubit = MockFaqCubit();
    when(mockFaqCubit.faqData).thenReturn(FaqModel(feq: faqsList));
    when(mockFaqCubit.userName).thenReturn("test user");
    when(mockFaqCubit.query).thenReturn("test");
    when(mockFaqCubit.searchBarController).thenReturn(TextEditingController());
    when(mockFaqCubit.state).thenReturn(FreqInitial());
    final Stream<FaqState> stream = Stream<FaqState>.fromIterable(<FaqState>[
      FreqInitial(),
      FreqLoading(),
      FreqLoaded(),
    ]);

    when(mockFaqCubit.stream).thenAnswer(
      (Invocation i) => stream,
    );
    when(mockFaqCubit.faqFilteredList).thenReturn(faqsList);
  });
  group('testing FaqCubit screen', () {
    testWidgets('testing FaqCubit view', (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider<FaqCubit>(
        create: (BuildContext context) => mockFaqCubit,
        child: MaterialApp(
          navigatorKey: globalKey,
          home: Scaffold(
              body: FaqScreenBody(
            controller: mockFaqCubit,
          )),
        ),
      ));
      expect(find.text(tr("no_answer")), findsOneWidget);
      expect(find.text(tr("contact_us")), findsOneWidget);
      await tester.enterText(find.byType(ParentTextField), mockFaqCubit.query);
      expect(find.text('Hi ${mockFaqCubit.userName},'), findsOneWidget);
      expect(find.text(mockFaqCubit.query), findsOneWidget);
      expect(tester.widgetList(find.bySubtype<SingleFAQItem>()).length, 1);
    });
  });
}
