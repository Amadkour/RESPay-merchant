import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/controller/cards_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/repository/cards_section_repository.dart';
import 'package:res_pay_merchant/features/payment/modules/add_card/api/model/payment_method.dart';

import 'credit_cards_cubit_test.mocks.dart';

@GenerateMocks(<Type>[CardsSectionRepository])
void main() {
  late MockCardsSectionRepository repository;

  final ApiFailure failure = ApiFailure();
  setUpAll(() {
    repository = MockCardsSectionRepository();
  });

  group('test group for card cubit', () {
    ///--------get payment method testing------///
    blocTest<CardsCubit, CardsState>(
      'verify that get payment method return success',
      build: () {
        when(repository.getPaymentMethods()).thenAnswer((Invocation realInvocation) async => right(<PaymentMethod>[]));
        return CardsCubit(repository);
      },
      act: (CardsCubit bloc) => bloc.getPaymentMethods(),
      expect: () => <CardsState>[GetPaymentMethodsLoading(), CardsPaymentMethodsLoaded()],
      verify: (CardsCubit bloc) => verify(repository.getPaymentMethods()).called(1),
    );

    blocTest<CardsCubit, CardsState>(
      'verify that get payment method return failure',
      build: () {
        when(repository.getPaymentMethods()).thenAnswer((Invocation realInvocation) async => left(failure));
        return CardsCubit(repository);
      },
      act: (CardsCubit bloc) => bloc.getPaymentMethods(),
      expect: () => <CardsState>[GetPaymentMethodsLoading(), GetPaymentMethodsFailure(failure)],
      verify: (CardsCubit bloc) => verify(repository.getPaymentMethods()).called(1),
    );
  });
}
