import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/controller/login_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/repository/login_repository.dart';

import '../provider/login_values.dart';
import 'login_cubit_test.mocks.dart';

@GenerateMocks(<Type>[
  LoginRepository,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockLoginRepository repository;

  final ApiFailure failure =
      ApiFailure(errors: loginFailedResponse['errors'] as Map<String, String>);
  setUpAll(() {
    repository = MockLoginRepository();
  });
  group('test Login cubit', () {
    ///-------- onChangeTabIndex ------///
    blocTest<LoginCubit, LoginState>(
      'Test onChangeTabIndex method',
      build: () => LoginCubit(repository),
      act: (LoginCubit bloc) => bloc.onChangeTabIndex(1),
      expect: () =>
          <TypeMatcher<LoginState>>[isA<LoginControllerChangeTabIndexState>()],
    );

    ///-------- changePasswordPhoneNumberSecureTextState ------///
    blocTest<LoginCubit, LoginState>(
      'Test onChangeTabIndex method',
      build: () => LoginCubit(repository),
      act: (LoginCubit bloc) => bloc.changeSecurePassword(),
      expect: () => <TypeMatcher<LoginState>>[
        isA<LoginControllerChangePasswordSecureTextState>()
      ],
    );

    ///-------- changePasswordIDNumberSecureTextState ------///
    blocTest<LoginCubit, LoginState>(
      'Test onChangeTabIndex method',
      build: () => LoginCubit(repository),
      act: (LoginCubit bloc) => bloc.changeSecurePassword(),
      expect: () => <TypeMatcher<LoginState>>[
        isA<LoginControllerChangePasswordSecureTextState>()
      ],
    );

    ///-------- changePasswordEmailSecureTextState ------///
    blocTest<LoginCubit, LoginState>(
      'Test onChangeTabIndex method',
      build: () => LoginCubit(repository),
      act: (LoginCubit bloc) => bloc.changeSecurePassword(),
      expect: () => <TypeMatcher<LoginState>>[
        isA<LoginControllerChangePasswordSecureTextState>()
      ],
    );

    ///-------- changeLanguage ------///
    blocTest<LoginCubit, LoginState>(
      'Test changeLanguage method',
      build: () => LoginCubit(repository),
      act: (LoginCubit bloc) {
        sl.registerLazySingleton(() => GlobalCubit());
        bloc.changeLanguage("en");
      },
      expect: () => <TypeMatcher<LoginState>>[
        isA<LoginControllerChangeLanguageDropDownState>()
      ],
    );

    ///-------- Success onTapButton ------///
    blocTest<LoginCubit, LoginState>(
      'onSuccess Test onTapButton functionality',
      build: () {
        when(repository.loginRepository(loginInput)).thenAnswer(
            (Invocation realInvocation) async =>
                Right<Failure, Map<String, dynamic>>(loginSuccessResponse));
        return LoginCubit(repository);
      },
      act: (LoginCubit bloc) {
        /// Go to id Number Tab to Login
        bloc.tabIndex = 1;
        bloc.idController.text = successInput['identity_id'] as String;
        // bloc.passwordIDNumberController.text =
        //     successInput['password'] as String;
        bloc.onTapButton(onSuccess: () {});
      },
      expect: () => <TypeMatcher<LoginState>>[
        isA<LoginControllerIsLoginLoading>(),
        isA<LoginControllerIsLoginFinishLoading>()
      ],
      verify: (LoginCubit bloc) =>
          verify(repository.loginRepository(loginInput)).called(1),
    );
  });

  ///-------- Failure onTapButton ------///
  blocTest<LoginCubit, LoginState>(
    'onFail Test onTapButton functionality',
    build: () {
      when(repository.loginRepository(failureLoginInput)).thenAnswer(
          (Invocation realInvocation) async =>
              Left<Failure, Map<String, dynamic>>(failure));
      return LoginCubit(repository);
    },
    act: (LoginCubit bloc) {
      /// Go to id Number Tab to Login
      bloc.tabIndex = 1;
      bloc.idController.text = failureInput['identity_id'] as String;
      bloc.passwordController.text = failureInput['password'] as String;
      bloc.onTapButton(onSuccess: () {});
    },
    expect: () => <TypeMatcher<LoginState>>[
      isA<LoginControllerIsLoginLoading>(),
      isA<LoginControllerFailure>(),
      isA<LoginControllerIsLoginFinishLoading>()
    ],
    verify: (LoginCubit bloc) =>
        verify(repository.loginRepository(failureLoginInput)).called(1),
  );
}
