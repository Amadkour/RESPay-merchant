// Mocks generated by Mockito 5.3.2 from annotations
// in res_pay/test/history/provider/repo/history_repo_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:dio/dio.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:res_pay_merchant/core/errors/failures.dart' as _i6;
import 'package:res_pay_merchant/features/payment/modules/history/provider/api/remote_transaction_api.dart'
    as _i4;
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/history_filter_input.dart'
    as _i7;

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

class _FakeDio_0 extends _i1.SmartFake implements _i2.Dio {
  _FakeDio_0(
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

/// A class which mocks [HistoryApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockHistoryApi extends _i1.Mock implements _i4.HistoryApi {
  MockHistoryApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Dio get dio => (super.noSuchMethod(
        Invocation.getter(#dio),
        returnValue: _FakeDio_0(
          this,
          Invocation.getter(#dio),
        ),
      ) as _i2.Dio);
  @override
  set dio(_i2.Dio? _dio) => super.noSuchMethod(
        Invocation.setter(
          #dio,
          _dio,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i2.Response<Map<String, dynamic>>>>
      getWallet() => (super.noSuchMethod(
            Invocation.method(
              #getWallet,
              [],
            ),
            returnValue: _i5.Future<
                    _i3.Either<_i6.Failure,
                        _i2.Response<Map<String, dynamic>>>>.value(
                _FakeEither_1<_i6.Failure, _i2.Response<Map<String, dynamic>>>(
              this,
              Invocation.method(
                #getWallet,
                [],
              ),
            )),
          ) as _i5.Future<
              _i3.Either<_i6.Failure, _i2.Response<Map<String, dynamic>>>>);
  @override
  _i5.Future<_i3.Either<_i6.Failure, _i2.Response<Map<String, dynamic>>>>
      getTransactions({_i7.HistoryFilterInput? filters}) => (super.noSuchMethod(
            Invocation.method(
              #getTransactions,
              [],
              {#filters: filters},
            ),
            returnValue: _i5.Future<
                    _i3.Either<_i6.Failure,
                        _i2.Response<Map<String, dynamic>>>>.value(
                _FakeEither_1<_i6.Failure, _i2.Response<Map<String, dynamic>>>(
              this,
              Invocation.method(
                #getTransactions,
                [],
                {#filters: filters},
              ),
            )),
          ) as _i5.Future<
              _i3.Either<_i6.Failure, _i2.Response<Map<String, dynamic>>>>);
}

/// A class which mocks [HistoryFilterInput].
///
/// See the documentation for Mockito's code generation for more information.
class MockHistoryFilterInput extends _i1.Mock
    implements _i7.HistoryFilterInput {
  MockHistoryFilterInput() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<Object?> get props => (super.noSuchMethod(
        Invocation.getter(#props),
        returnValue: <Object?>[],
      ) as List<Object?>);
  @override
  Map<String, dynamic> toMap() => (super.noSuchMethod(
        Invocation.method(
          #toMap,
          [],
        ),
        returnValue: <String, dynamic>{},
      ) as Map<String, dynamic>);
}
