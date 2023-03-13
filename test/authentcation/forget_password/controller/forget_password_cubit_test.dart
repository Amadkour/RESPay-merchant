import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/controller/forget_password/forget_password_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/forget_password/provider/repository/forget_passwod_repository.dart';

import 'forget_password_cubit_test.mocks.dart';

@GenerateMocks(<Type>[
  ForgetPasswordRepository,
])
void main() {
  late MockForgetPasswordRepository repository;

  final ApiFailure failure = ApiFailure();
  setUpAll(() {
    repository = MockForgetPasswordRepository();
  });

  group('test Forget password cubit', () {
    ///-------- changePhoneExpansion ------///
    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'Test that phoneExpanded changed',
      build: () => ForgetPasswordCubit(repository),
      act: (ForgetPasswordCubit bloc) => bloc.changePhoneExpansion(),
      expect: () =>
          <TypeMatcher<ForgetPasswordState>>[isA<ForgetPasswordExpand>()],
    );

    ///-------- changeEmailExpansion ------///
    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'Test that emailExpanded changed',
      build: () => ForgetPasswordCubit(repository),
      act: (ForgetPasswordCubit bloc) => bloc.changeEmailExpansion(),
      expect: () =>
          <TypeMatcher<ForgetPasswordState>>[isA<ForgetPasswordExpand>()],
    );

    ///-------- changeIDNumberExpansion ------///
    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'Test that idNumberExpanded changed',
      build: () => ForgetPasswordCubit(repository),
      act: (ForgetPasswordCubit bloc) => bloc.changeIDNumberExpansion(),
      expect: () =>
          <TypeMatcher<ForgetPasswordState>>[isA<ForgetPasswordExpand>()],
    );

    ///-------- Success onTapButton ------///
    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'onSuccess Test onTapButton functionality',
      build: () {
        when(repository.forgotPasswordRepository(
                identifier: <String, String>{"identity_id": "20232023"}))
            .thenAnswer((Invocation realInvocation) async =>
                const Right<Failure, String>("1234"));

        return ForgetPasswordCubit(repository);
      },
      act: (ForgetPasswordCubit bloc) {
        bloc.idController.text = "20232023";
        bloc.onTabButton(onSuccess: (String otp) {});
      },
      expect: () => <TypeMatcher<ForgetPasswordState>>[
        isA<ForgetPasswordLoading>(),
        isA<ForgetPasswordFinishLoading>()
      ],
      verify: (ForgetPasswordCubit bloc) => verify(repository
              .forgotPasswordRepository(
                  identifier: <String, String>{"identity_id": "20232023"}))
          .called(1),
    );

    ///-------- Failure onTapButton ------///
    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'onFail Test onTapButton functionality',
      build: () {
        when(repository.forgotPasswordRepository(
                identifier: <String, String>{"identity_id": "20232023"}))
            .thenAnswer((Invocation realInvocation) async =>
                Left<Failure, String>(failure));

        return ForgetPasswordCubit(repository);
      },
      act: (ForgetPasswordCubit bloc) {
        bloc.idController.text = "20232023";
        bloc.onTabButton(onSuccess: (String otp) {});
      },
      expect: () => <TypeMatcher<ForgetPasswordState>>[
        isA<ForgetPasswordLoading>(),
        isA<ForgetPasswordFailure>(),
        isA<ForgetPasswordFinishLoading>()
      ],
      verify: (ForgetPasswordCubit bloc) => verify(repository
              .forgotPasswordRepository(
                  identifier: <String, String>{"identity_id": "20232023"}))
          .called(1),
    );
  });
}
