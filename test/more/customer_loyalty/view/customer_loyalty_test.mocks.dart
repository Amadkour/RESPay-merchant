// Mocks generated by Mockito 5.3.2 from annotations
// in res_pay/test/more/customer_loyalty/view/customer_loyalty_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:flutter_bloc/flutter_bloc.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/controller/customer_loyalty_cubit.dart'
    as _i2;
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/models/customer_loyality_model.dart'
    as _i4;
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/customer_loyality/provider/models/customer_loyalty_list_model.dart'
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

class _FakeCustomerLoyaltyState_0 extends _i1.SmartFake
    implements _i2.CustomerLoyaltyState {
  _FakeCustomerLoyaltyState_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CustomerLoyaltyCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockCustomerLoyaltyCubit extends _i1.Mock
    implements _i2.CustomerLoyaltyCubit {
  MockCustomerLoyaltyCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  set loyaltyModel(_i3.CustomerLoyaltyListModel? _loyaltyModel) =>
      super.noSuchMethod(
        Invocation.setter(
          #loyaltyModel,
          _loyaltyModel,
        ),
        returnValueForMissingStub: null,
      );
  @override
  set selectedCustomerLoyalty(
          _i4.CustomerLoyaltyModel? _selectedCustomerLoyalty) =>
      super.noSuchMethod(
        Invocation.setter(
          #selectedCustomerLoyalty,
          _selectedCustomerLoyalty,
        ),
        returnValueForMissingStub: null,
      );
  @override
  List<_i4.CustomerLoyaltyModel> get customerList => (super.noSuchMethod(
        Invocation.getter(#customerList),
        returnValue: <_i4.CustomerLoyaltyModel>[],
      ) as List<_i4.CustomerLoyaltyModel>);
  @override
  bool get canRefresh => (super.noSuchMethod(
        Invocation.getter(#canRefresh),
        returnValue: false,
      ) as bool);
  @override
  set canRefresh(bool? _canRefresh) => super.noSuchMethod(
        Invocation.setter(
          #canRefresh,
          _canRefresh,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i2.CustomerLoyaltyState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeCustomerLoyaltyState_0(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.CustomerLoyaltyState);
  @override
  _i5.Stream<_i2.CustomerLoyaltyState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i5.Stream<_i2.CustomerLoyaltyState>.empty(),
      ) as _i5.Stream<_i2.CustomerLoyaltyState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  _i5.Future<void> onInit() => (super.noSuchMethod(
        Invocation.method(
          #onInit,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<void> show(_i4.CustomerLoyaltyModel? shop) => (super.noSuchMethod(
        Invocation.method(
          #show,
          [shop],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  _i5.Future<String> redeem() => (super.noSuchMethod(
        Invocation.method(
          #redeem,
          [],
        ),
        returnValue: _i5.Future<String>.value(''),
      ) as _i5.Future<String>);
  @override
  void oChangRate(int? newRate) => super.noSuchMethod(
        Invocation.method(
          #oChangRate,
          [newRate],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<void> onRefresh() => (super.noSuchMethod(
        Invocation.method(
          #onRefresh,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
  @override
  void emit(_i2.CustomerLoyaltyState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onChange(_i6.Change<_i2.CustomerLoyaltyState>? change) =>
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
  @override
  _i5.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}
