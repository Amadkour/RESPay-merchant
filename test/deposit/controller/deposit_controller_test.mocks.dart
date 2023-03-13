// Mocks generated by Mockito 5.3.2 from annotations
// in res_pay/test/deposit/controller/deposit_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:bloc/bloc.dart' as _i12;
import 'package:dartz/dartz.dart' as _i2;
import 'package:flutter/material.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:res_pay_merchant/core/errors/failures.dart' as _i7;
import 'package:res_pay_merchant/features/payment/modules/deposit/provider/model/create_deposit_input.dart'
    as _i9;
import 'package:res_pay_merchant/features/payment/modules/deposit/provider/repo/deposit_repo.dart'
    as _i5;
import 'package:res_pay_merchant/features/payment/modules/history/controller/transaction_history_cubit.dart'
    as _i4;
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/transaction_model.dart'
    as _i10;
import 'package:res_pay_merchant/features/payment/modules/history/provider/model/wallet.dart'
    as _i11;
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart'
    as _i8;

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

class _FakeTextEditingController_1 extends _i1.SmartFake
    implements _i3.TextEditingController {
  _FakeTextEditingController_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTransactionHistoryState_2 extends _i1.SmartFake
    implements _i4.TransactionHistoryState {
  _FakeTransactionHistoryState_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DepositRepo].
///
/// See the documentation for Mockito's code generation for more information.
class MockDepositRepo extends _i1.Mock implements _i5.DepositRepo {
  MockDepositRepo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.Failure, _i8.ReceiptModel>> create(
          _i9.CreateDepositInput? input) =>
      (super.noSuchMethod(
        Invocation.method(
          #create,
          [input],
        ),
        returnValue:
            _i6.Future<_i2.Either<_i7.Failure, _i8.ReceiptModel>>.value(
                _FakeEither_0<_i7.Failure, _i8.ReceiptModel>(
          this,
          Invocation.method(
            #create,
            [input],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.Failure, _i8.ReceiptModel>>);
}

/// A class which mocks [TransactionHistoryCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockTransactionHistoryCubit extends _i1.Mock
    implements _i4.TransactionHistoryCubit {
  MockTransactionHistoryCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i10.TransactionModel> get transactions => (super.noSuchMethod(
        Invocation.getter(#transactions),
        returnValue: <_i10.TransactionModel>[],
      ) as List<_i10.TransactionModel>);
  @override
  set transactions(List<_i10.TransactionModel>? _transactions) =>
      super.noSuchMethod(
        Invocation.setter(
          #transactions,
          _transactions,
        ),
        returnValueForMissingStub: null,
      );
  @override
  set wallet(_i11.Wallet? _wallet) => super.noSuchMethod(
        Invocation.setter(
          #wallet,
          _wallet,
        ),
        returnValueForMissingStub: null,
      );
  @override
  set filterCategory(String? _filterCategory) => super.noSuchMethod(
        Invocation.setter(
          #filterCategory,
          _filterCategory,
        ),
        returnValueForMissingStub: null,
      );
  @override
  set period(String? _period) => super.noSuchMethod(
        Invocation.setter(
          #period,
          _period,
        ),
        returnValueForMissingStub: null,
      );
  @override
  String get query => (super.noSuchMethod(
        Invocation.getter(#query),
        returnValue: '',
      ) as String);
  @override
  set query(String? _query) => super.noSuchMethod(
        Invocation.setter(
          #query,
          _query,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.TextEditingController get from => (super.noSuchMethod(
        Invocation.getter(#from),
        returnValue: _FakeTextEditingController_1(
          this,
          Invocation.getter(#from),
        ),
      ) as _i3.TextEditingController);
  @override
  set from(_i3.TextEditingController? _from) => super.noSuchMethod(
        Invocation.setter(
          #from,
          _from,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.TextEditingController get to => (super.noSuchMethod(
        Invocation.getter(#to),
        returnValue: _FakeTextEditingController_1(
          this,
          Invocation.getter(#to),
        ),
      ) as _i3.TextEditingController);
  @override
  set to(_i3.TextEditingController? _to) => super.noSuchMethod(
        Invocation.setter(
          #to,
          _to,
        ),
        returnValueForMissingStub: null,
      );
  @override
  Map<String, List<_i10.TransactionModel>> get groupedData =>
      (super.noSuchMethod(
        Invocation.getter(#groupedData),
        returnValue: <String, List<_i10.TransactionModel>>{},
      ) as Map<String, List<_i10.TransactionModel>>);
  @override
  Map<String, String> get periodTypes => (super.noSuchMethod(
        Invocation.getter(#periodTypes),
        returnValue: <String, String>{},
      ) as Map<String, String>);
  @override
  List<String> get transactionTypes => (super.noSuchMethod(
        Invocation.getter(#transactionTypes),
        returnValue: <String>[],
      ) as List<String>);
  @override
  _i4.TransactionHistoryState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeTransactionHistoryState_2(
          this,
          Invocation.getter(#state),
        ),
      ) as _i4.TransactionHistoryState);
  @override
  _i6.Stream<_i4.TransactionHistoryState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i6.Stream<_i4.TransactionHistoryState>.empty(),
      ) as _i6.Stream<_i4.TransactionHistoryState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  _i6.Future<void> init() => (super.noSuchMethod(
        Invocation.method(
          #init,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> getWallet() => (super.noSuchMethod(
        Invocation.method(
          #getWallet,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> loadTransactions() => (super.noSuchMethod(
        Invocation.method(
          #loadTransactions,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> getAllTransactions() => (super.noSuchMethod(
        Invocation.method(
          #getAllTransactions,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> filterByCategory() => (super.noSuchMethod(
        Invocation.method(
          #filterByCategory,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> filterByPeriod() => (super.noSuchMethod(
        Invocation.method(
          #filterByPeriod,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  _i6.Future<void> searchInTransactions({required String? query}) =>
      (super.noSuchMethod(
        Invocation.method(
          #searchInTransactions,
          [],
          {#query: query},
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  void setPeriod(String? period) => super.noSuchMethod(
        Invocation.method(
          #setPeriod,
          [period],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void setCategory(String? category) => super.noSuchMethod(
        Invocation.method(
          #setCategory,
          [category],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void resetValues() => super.noSuchMethod(
        Invocation.method(
          #resetValues,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i6.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);
  @override
  void emit(_i4.TransactionHistoryState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onChange(_i12.Change<_i4.TransactionHistoryState>? change) =>
      super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}
