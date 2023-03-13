import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/controllers/faq_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/FAQs/provider/model/faq_model.dart';

void main() {
  final List<Faqs> faqs = <Faqs>[Faqs(subFaqs: <Faqs>[])];

  group('FAQ Cubit test', () {
    blocTest<FaqCubit, FaqState>('onChangeSearch TEST',
        build: () {
          return FaqCubit(faqs: FaqModel(feq: faqs));
        },
        act: (FaqCubit cubit) {
          cubit.onChangeSearch("a");
        },
        expect: () => <TypeMatcher<FaqState>>[
              isA<FreqLoaded>(),
            ]);

    blocTest<FaqCubit, FaqState>('onClick TEST',
        build: () {
          return FaqCubit(faqs: FaqModel(feq: faqs));
        },
        act: (FaqCubit cubit) {
          cubit.onClick(0);

        },
        expect: () => <TypeMatcher<FaqState>>[
              isA<FreqLoaded>(),
            ]);
  });
}
