import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/exceptions.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/API/cards_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/repository/cards_section_repository.dart';
import 'package:res_pay_merchant/features/payment/modules/add_card/api/model/payment_method.dart';

import '../card_values.dart';
import 'cards_repo_test.mocks.dart';

@GenerateMocks(<Type>[CardsAPI])
void main() {
  late MockCardsAPI api;
  late CardsSectionRepository repository;
  setUpAll(() {
    api = MockCardsAPI();
    repository = CardsSectionRepository(api: api);
  });

  group("cards repo layer testing", () {
    //-----test get payment method----///
    test('verify get payment method return list of payment methods', () async {
      when(api.getPaymentMethods()).thenAnswer((Invocation realInvocation) async {
        return getPaymentMethodSuccessResponse['data'] as Map<String, dynamic>;
      });

      final Either<Failure, List<PaymentMethod>> result = await repository.getPaymentMethods();

      final Object list = result.fold((Failure l) => l, (List<PaymentMethod> r) => r);
      expect(list, isA<List<PaymentMethod>>());
    });

    test('verify get payment method return failure', () async {
      when(api.getPaymentMethods()).thenThrow(ServerException(
        message: "server exception",
        statusCode: 500,
      ));

      final Either<Failure, List<PaymentMethod>> result = await repository.getPaymentMethods();

      final Object list = result.fold((Failure l) => l, (List<PaymentMethod> r) => r);
      expect(list, isA<ApiFailure>());
    });

    //-----test get user cards----///
    test('verify get cards return list of CreditCardModel', () async {
      when(api.getCreditCards()).thenAnswer((Invocation realInvocation) async {
        return getCreditCardsMethodValues.successfulResponse['data'] as Map<String, dynamic>;
      });

      final Either<Failure, List<CreditCardModel>> result = await repository.getCardsRepository();

      final Object list = result.fold((Failure l) => l, (List<CreditCardModel> r) => r);
      expect(list, isA<List<CreditCardModel>>());
    });

    test('verify get payment method return failure', () async {
      when(api.getCreditCards()).thenThrow(ServerException(
        message: "server exception",
        statusCode: 500,
      ));

      final Either<Failure, List<PaymentMethod>> result = await repository.getPaymentMethods();

      final Object list = result.fold((Failure l) => l, (List<PaymentMethod> r) => r);
      expect(list, isA<ApiFailure>());
    });

    //-----test add credit card----///
    test('verify add function added successfully', () async {
      when(api.createCard(addCardParams)).thenAnswer((Invocation realInvocation) async {
        return true;
      });

      final Option<Failure> result = await repository.createCard(addCardParams);

      expect(result, isA<None<dynamic>>());
    });

    test('verify add card function return some of failure', () async {
      when(api.createCard(addCardParams)).thenThrow(ServerException(
        message: "server exception",
        statusCode: 500,
      ));

      final Option<Failure> result = await repository.createCard(addCardParams);

      expect(result, isA<Some<Failure>>());
    });

    //-----test delete credit card----///
    test('verify delete function deleted successfully', () async {
      when(api.createCard(addCardParams)).thenAnswer((Invocation realInvocation) async {
        return true;
      });

      final Option<Failure> result = await repository.createCard(addCardParams);

      expect(result, isA<None<dynamic>>());
    });

    test('verify delete card function return some of failure', () async {
      when(api.deleteCard(any)).thenThrow(ServerException(
        message: "server exception",
        statusCode: 500,
      ));

      final Option<Failure> result = await repository.deleteCard("1223");

      expect(result, isA<Some<Failure>>());
    });
  });
}
