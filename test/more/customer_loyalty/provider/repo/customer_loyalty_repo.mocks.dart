// Mocks generated by Mockito 5.3.2 from annotations
// in res_pay/test/more/customer_loyalty/provider/repo/customer_loyalty_repo.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:dio/dio.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:res_pay_merchant/core/errors/failures.dart' as _i5;
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/api/customer_loyalty_api.dart'
    as _i3;

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

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CustomerLoyaltyApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockCustomerLoyaltyApi extends _i1.Mock
    implements _i3.CustomerLoyaltyApi {
  MockCustomerLoyaltyApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Response<Map<String, dynamic>>>>
      getLoyalties() => (super.noSuchMethod(
            Invocation.method(
              #getLoyalties,
              [],
            ),
            returnValue: _i4.Future<
                    _i2.Either<_i5.Failure,
                        _i6.Response<Map<String, dynamic>>>>.value(
                _FakeEither_0<_i5.Failure, _i6.Response<Map<String, dynamic>>>(
              this,
              Invocation.method(
                #getLoyalties,
                [],
              ),
            )),
          ) as _i4.Future<
              _i2.Either<_i5.Failure, _i6.Response<Map<String, dynamic>>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Response<Map<String, dynamic>>>> show(
          String? uuid) =>
      (super.noSuchMethod(
        Invocation.method(
          #show,
          [uuid],
        ),
        returnValue: _i4.Future<
                _i2.Either<_i5.Failure,
                    _i6.Response<Map<String, dynamic>>>>.value(
            _FakeEither_0<_i5.Failure, _i6.Response<Map<String, dynamic>>>(
          this,
          Invocation.method(
            #show,
            [uuid],
          ),
        )),
      ) as _i4
          .Future<_i2.Either<_i5.Failure, _i6.Response<Map<String, dynamic>>>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Response<Map<String, dynamic>>>>
      redeem(String? uuid) => (super.noSuchMethod(
            Invocation.method(
              #redeem,
              [uuid],
            ),
            returnValue: _i4.Future<
                    _i2.Either<_i5.Failure,
                        _i6.Response<Map<String, dynamic>>>>.value(
                _FakeEither_0<_i5.Failure, _i6.Response<Map<String, dynamic>>>(
              this,
              Invocation.method(
                #redeem,
                [uuid],
              ),
            )),
          ) as _i4.Future<
              _i2.Either<_i5.Failure, _i6.Response<Map<String, dynamic>>>>);
}
