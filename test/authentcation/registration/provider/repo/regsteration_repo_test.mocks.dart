// Mocks generated by Mockito 5.3.2 from annotations
// in res_pay/test/authentcation/registration/provider/repo/regsteration_repo_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:dio/dio.dart' as _i6;
import 'package:mockito/mockito.dart' as _i1;
import 'package:res_pay_merchant/core/errors/failures.dart' as _i5;
import 'package:res_pay_merchant/features/authentication/modules/registration/providers/Api/registration_api.dart'
    as _i3;
import 'package:res_pay_merchant/features/authentication/modules/registration/providers/models/register_inputs.dart'
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

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [RegistrationAPI].
///
/// See the documentation for Mockito's code generation for more information.
class MockRegistrationAPI extends _i1.Mock implements _i3.RegistrationAPI {
  MockRegistrationAPI() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.Response<Map<String, dynamic>>>>
      registration(_i7.RegisterInputs? inputs) => (super.noSuchMethod(
            Invocation.method(
              #registration,
              [inputs],
            ),
            returnValue: _i4.Future<
                    _i2.Either<_i5.Failure,
                        _i6.Response<Map<String, dynamic>>>>.value(
                _FakeEither_0<_i5.Failure, _i6.Response<Map<String, dynamic>>>(
              this,
              Invocation.method(
                #registration,
                [inputs],
              ),
            )),
          ) as _i4.Future<
              _i2.Either<_i5.Failure, _i6.Response<Map<String, dynamic>>>>);
}
