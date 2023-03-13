// Mocks generated by Mockito 5.3.2 from annotations
// in res_pay/test/cards/controller/credit_cards_cubit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:res_pay_merchant/core/errors/failures.dart' as _i7;
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/credit_card_model.dart'
    as _i8;
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/model/transaction_global_model.dart'
    as _i6;
import 'package:res_pay_merchant/features/dashboard/modules/home/modules/cards/provider/repository/cards_section_repository.dart'
    as _i4;
import 'package:res_pay_merchant/features/dashboard/modules/home/provider/model/limits_model.dart'
    as _i2;
import 'package:res_pay_merchant/features/payment/modules/add_card/api/model/create_card_input.dart'
    as _i10;
import 'package:res_pay_merchant/features/payment/modules/add_card/api/model/payment_method.dart'
    as _i9;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeLimitsModel_0 extends _i1.SmartFake implements _i2.LimitsModel {
  _FakeLimitsModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeOption_2<A> extends _i1.SmartFake implements _i3.Option<A> {
  _FakeOption_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CardsSectionRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCardsSectionRepository extends _i1.Mock
    implements _i4.CardsSectionRepository {
  MockCardsSectionRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.LimitsModel> getAllLimits() => (super.noSuchMethod(
        Invocation.method(
          #getAllLimits,
          [],
        ),
        returnValue: _i5.Future<_i2.LimitsModel>.value(_FakeLimitsModel_0(
          this,
          Invocation.method(
            #getAllLimits,
            [],
          ),
        )),
      ) as _i5.Future<_i2.LimitsModel>);
  @override
  _i5.Future<List<_i6.TransactionGlobalModel>> getAllTransactions() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAllTransactions,
          [],
        ),
        returnValue: _i5.Future<List<_i6.TransactionGlobalModel>>.value(
            <_i6.TransactionGlobalModel>[]),
      ) as _i5.Future<List<_i6.TransactionGlobalModel>>);
  @override
  _i5.Future<_i3.Either<_i7.Failure, List<_i8.CreditCardModel>>>
      getCardsRepository() => (super.noSuchMethod(
            Invocation.method(
              #getCardsRepository,
              [],
            ),
            returnValue: _i5.Future<
                    _i3.Either<_i7.Failure, List<_i8.CreditCardModel>>>.value(
                _FakeEither_1<_i7.Failure, List<_i8.CreditCardModel>>(
              this,
              Invocation.method(
                #getCardsRepository,
                [],
              ),
            )),
          ) as _i5.Future<_i3.Either<_i7.Failure, List<_i8.CreditCardModel>>>);
  @override
  _i5.Future<
      _i3
          .Either<_i7.Failure, List<_i9.PaymentMethod>>> getPaymentMethods() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPaymentMethods,
          [],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i7.Failure, List<_i9.PaymentMethod>>>.value(
                _FakeEither_1<_i7.Failure, List<_i9.PaymentMethod>>(
          this,
          Invocation.method(
            #getPaymentMethods,
            [],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i7.Failure, List<_i9.PaymentMethod>>>);
  @override
  _i5.Future<_i3.Option<_i7.Failure>> createCard(_i10.CreateCardInput? input) =>
      (super.noSuchMethod(
        Invocation.method(
          #createCard,
          [input],
        ),
        returnValue: _i5.Future<_i3.Option<_i7.Failure>>.value(
            _FakeOption_2<_i7.Failure>(
          this,
          Invocation.method(
            #createCard,
            [input],
          ),
        )),
      ) as _i5.Future<_i3.Option<_i7.Failure>>);
  @override
  _i5.Future<_i3.Option<_i7.Failure>> deleteCard(String? uuid) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteCard,
          [uuid],
        ),
        returnValue: _i5.Future<_i3.Option<_i7.Failure>>.value(
            _FakeOption_2<_i7.Failure>(
          this,
          Invocation.method(
            #deleteCard,
            [uuid],
          ),
        )),
      ) as _i5.Future<_i3.Option<_i7.Failure>>);
}