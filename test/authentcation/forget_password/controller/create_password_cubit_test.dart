import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/controller/create_new_password/create_new_password_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/repository/create_new_password_repository.dart';

import 'create_password_cubit_test.mocks.dart';

@GenerateMocks(<Type>[
  CreateNewPasswordRepository,
])
void main() {
  late MockCreateNewPasswordRepository repository;

  final ApiFailure failure = ApiFailure(errors: <String, dynamic>{
    "phone_number": <String>["error"]
  });
  setUpAll(() {
    repository = MockCreateNewPasswordRepository();
  });

  group('test Create password cubit', () {
    ///-------- changeCreateSecureText ------///
    blocTest<CreateNewPasswordCubit, CreateNewPasswordState>(
      'Test changeCreateSecureText method',
      build: () => CreateNewPasswordCubit(<String, dynamic>{}, repository),
      act: (CreateNewPasswordCubit bloc) => bloc.changeCreateSecureText(),
      expect: () => <TypeMatcher<CreateNewPasswordState>>[
        isA<CreateNewPasswordChangeSecureState>()
      ],
    );

    // ///-------- changeConfirmSecureText ------///
    // blocTest<CreateNewPasswordCubit, CreateNewPasswordState>(
    //   'Test changeConfirmSecureText method',
    //   build: () => CreateNewPasswordCubit(<String, dynamic>{}, repository),
    //   act: (CreateNewPasswordCubit bloc) => bloc.changeConfirmSecureText(),
    //   expect: () => <TypeMatcher<CreateNewPasswordState>>[
    //     isA<CreateNewPasswordChangeSecureState>()
    //   ],
    // );

    ///-------- Success onTapButton ------///
    blocTest<CreateNewPasswordCubit, CreateNewPasswordState>(
      'onSuccess Test onTapButton functionality',
      build: () {
        when(repository.resetPasswordRepository(map: <String, dynamic>{
          "password": "12345678",
          "password_confirmation": "12345678"
        })).thenAnswer((Invocation realInvocation) async =>
            const Right<Failure, Map<String, dynamic>>(<String, dynamic>{}));

        return CreateNewPasswordCubit(<String, dynamic>{}, repository);
      },
      act: (CreateNewPasswordCubit bloc) {
        bloc.createController.text = "12345678";
        bloc.confirmController.text = "12345678";
        bloc.onTabButton(onSuccess: () {});
      },
      expect: () => <TypeMatcher<CreateNewPasswordState>>[
        isA<CreateNewPasswordLoadingState>(),
        isA<CreateNewPasswordLoadingFinishedState>()
      ],
      verify: (CreateNewPasswordCubit bloc) => verify(repository
          .resetPasswordRepository(map: <String, dynamic>{
        "password": "12345678",
        "password_confirmation": "12345678"
      })).called(1),
    );

    ///-------- Failure onTapButton ------///
    blocTest<CreateNewPasswordCubit, CreateNewPasswordState>(
      'onFail Test onTapButton functionality',
      build: () {
        when(repository.resetPasswordRepository(map: <String, dynamic>{
          "password": "12345678",
          "password_confirmation": "12345678"
        })).thenAnswer((Invocation realInvocation) async =>
            Left<Failure, Map<String, dynamic>>(failure));

        return CreateNewPasswordCubit(<String, dynamic>{}, repository);
      },
      act: (CreateNewPasswordCubit bloc) {
        bloc.createController.text = "12345678";
        bloc.confirmController.text = "12345678";
        bloc.onTabButton(onSuccess: () {});
      },
      expect: () => <TypeMatcher<CreateNewPasswordState>>[
        isA<CreateNewPasswordLoadingState>(),
        isA<CreateNewPasswordFailure>(),
        isA<CreateNewPasswordLoadingFinishedState>()
      ],
      verify: (CreateNewPasswordCubit bloc) => verify(repository
          .resetPasswordRepository(map: <String, dynamic>{
        "password": "12345678",
        "password_confirmation": "12345678"
      })).called(1),
    );
  });
}
