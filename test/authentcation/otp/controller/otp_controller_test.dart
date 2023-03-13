import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/otp/controller/otp_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/otp/provider/repo/otp_repo.dart';

import 'otp_controller_test.mocks.dart';

@GenerateMocks(<Type>[OtpRepo])
void main() {
  late MockOtpRepo repo;

  setUpAll(() {
    repo = MockOtpRepo();
  });
  group(
    "verify otp method ",
    () {
      blocTest(
        'otp verify method test success state',
        build: () {
          when(repo.verify(any)).thenAnswer((Invocation realInvocation) async {
            return right('success');
          });
          return OtpCubit((String? code) async {}, true, repo);
        },
        act: (OtpCubit bloc) async {
          bloc.otpController.text = '1234';
          await bloc.onTapConfirmButton();
        },
        expect: () =>
            <TypeMatcher<OtpState>>[isA<OtpLoading>(), isA<OtpLoaded>()],
        verify: (OtpCubit bloc) => verify(repo.verify(any)).called(1),
      );

      blocTest(
        'otp verify method test error state',
        build: () {
          when(repo.verify(any)).thenAnswer((Invocation realInvocation) async {
            return left(ApiFailure());
          });
          return OtpCubit((String? code) async {}, true, repo);
        },
        act: (OtpCubit bloc) async {
          await bloc.onTapConfirmButton();
        },
        expect: () =>
            <TypeMatcher<OtpState>>[isA<OtpLoading>(), isA<OtpError>()],
        verify: (OtpCubit bloc) => verify(repo.verify(any)).called(1),
      );
    },
  );

  group("test change otp method", () {
    blocTest(
      'success state',
      build: () {
        when(repo.verify(any)).thenAnswer((Invocation realInvocation) async {
          return right('success');
        });

        return OtpCubit((String? code) async {}, true, repo);
      },
      act: (OtpCubit bloc) async {
        bloc.otpController.text = '1234';
        await bloc.onChangeOtp();
      },
      expect: () =>
          <TypeMatcher<OtpState>>[isA<OtpLoading>(), isA<OtpLoaded>()],
      verify: (OtpCubit bloc) {
        expect(bloc.otpController.text.isEmpty, true);
      },
    );

    blocTest(
      'error state',
      build: () {
        when(repo.verify(any)).thenAnswer((Invocation realInvocation) async {
          return left(ApiFailure());
        });

        return OtpCubit((String? code) async {}, true, repo);
      },
      act: (OtpCubit bloc) async {
        bloc.otpController.text = '1234';
        await bloc.onChangeOtp();
      },
      expect: () => <TypeMatcher<OtpState>>[isA<OtpLoading>(), isA<OtpError>()],
      verify: (OtpCubit bloc) {
        expect(bloc.otpController.text.isEmpty, true);
      },
    );
    late MockOtpRepo otpRepo;
    blocTest(
      'check if callback no executed if otp length != 4',
      setUp: () {
        otpRepo = MockOtpRepo();
      },
      build: () {
        return OtpCubit((String? code) async {}, true, repo);
      },
      act: (OtpCubit bloc) async {
        await bloc.onChangeOtp();
      },
      verify: (OtpCubit bloc) {
        verifyZeroInteractions(otpRepo);
      },
    );
  });
}
