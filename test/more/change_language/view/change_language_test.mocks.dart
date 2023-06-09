// Mocks generated by Mockito 5.3.2 from annotations
// in res_pay/test/more/change_language/view/change_language_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:bloc/bloc.dart' as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/controller/language_cubit.dart'
    as _i2;
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/provider/model/language_model.dart'
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

class _FakeLanguageState_0 extends _i1.SmartFake implements _i2.LanguageState {
  _FakeLanguageState_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LanguageCubit].
///
/// See the documentation for Mockito's code generation for more information.
class MockLanguageCubit extends _i1.Mock implements _i2.LanguageCubit {
  MockLanguageCubit() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i3.LanguageModel> get languageModels => (super.noSuchMethod(
        Invocation.getter(#languageModels),
        returnValue: <_i3.LanguageModel>[],
      ) as List<_i3.LanguageModel>);
  @override
  _i2.LanguageState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeLanguageState_0(
          this,
          Invocation.getter(#state),
        ),
      ) as _i2.LanguageState);
  @override
  _i4.Stream<_i2.LanguageState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i4.Stream<_i2.LanguageState>.empty(),
      ) as _i4.Stream<_i2.LanguageState>);
  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);
  @override
  _i4.Future<void> init() => (super.noSuchMethod(
        Invocation.method(
          #init,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
  @override
  void toggleLanguage(String? value) => super.noSuchMethod(
        Invocation.method(
          #toggleLanguage,
          [value],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i4.Future<String> onTapButton() => (super.noSuchMethod(
        Invocation.method(
          #onTapButton,
          [],
        ),
        returnValue: _i4.Future<String>.value(''),
      ) as _i4.Future<String>);
  @override
  void emit(_i2.LanguageState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void onChange(_i5.Change<_i2.LanguageState>? change) => super.noSuchMethod(
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
  _i4.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i4.Future<void>.value(),
        returnValueForMissingStub: _i4.Future<void>.value(),
      ) as _i4.Future<void>);
}
