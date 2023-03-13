import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/model/logged_in_user_model.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/controller/pin_code_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/provider/repo/pin_code_repo.dart';

import '../../../more/change_language/controller/change_language_cubit_test.mocks.dart';
import 'pin_code_controller_test.mocks.dart';

@GenerateMocks(<Type>[
  PinCodeRepo,
  LocalAuthentication,
])
void main() {
  late MockLocalAuthentication mockLocalAuthentication;
  late MockLocalStorageService mockLocalStorageService;
  late MockPinCodeRepo mockPinCodeRepo;

  setUpAll(() {
    mockLocalAuthentication = MockLocalAuthentication();
    mockLocalStorageService = MockLocalStorageService();
    mockPinCodeRepo = MockPinCodeRepo();
  });
  group('on Done with bio metric', () {
    blocTest(
      'on Done with bio metric success state',
      build: () {
        return PinCodeCubit(
          auth: mockLocalAuthentication,
          service: mockLocalStorageService,
          repo: mockPinCodeRepo,
        );
      },
      act: (PinCodeCubit bloc) async {
        when(mockPinCodeRepo.setup('1234', 1, 1))
            .thenAnswer((Invocation realInvocation) async {
          return right(true);
        });

        when(mockLocalStorageService.setFaceIdValue(faceId: true))
            .thenAnswer((Invocation realInvocation) async {
          return;
        });

        when(mockLocalStorageService.setTouchIdValue(touchId: true))
            .thenAnswer((Invocation realInvocation) async {
          return;
        });

        bloc.pinCode = '1234';
        await bloc.onDoneWithBiometric();
      },
      expect: () => <TypeMatcher<PinCodeState>>[
        isA<PinCodeOnDoneWithBiometricsLoading>(),
        isA<PinCodeLoaded>()
      ],
      verify: (PinCodeCubit bloc) {
        expect(bloc.pinCode.isEmpty, true);
        expect(bloc.faceIdEnabled, true);
        expect(bloc.fingerPrintEnabled, true);
        verify(mockPinCodeRepo.setup('1234', 1, 1)).called(1);
      },
    );

    blocTest(
      'on Done with bio metric failure state',
      build: () {
        return PinCodeCubit(
          auth: mockLocalAuthentication,
          service: mockLocalStorageService,
          repo: mockPinCodeRepo,
        );
      },
      act: (PinCodeCubit bloc) async {
        when(mockPinCodeRepo.setup('1234', 1, 1))
            .thenAnswer((Invocation realInvocation) async {
          return right(true);
        });

        when(mockLocalStorageService.setFaceIdValue(faceId: true))
            .thenThrow(Exception());

        when(mockLocalStorageService.setTouchIdValue(touchId: true))
            .thenAnswer((Invocation realInvocation) async {
          return;
        });

        bloc.pinCode = '1234';
        await bloc.onDoneWithBiometric();
      },
      expect: () => <TypeMatcher<PinCodeState>>[
        isA<PinCodeOnDoneWithBiometricsLoading>(),
        isA<PinCodeError>()
      ],
      verify: (PinCodeCubit bloc) {
        expect(bloc.pinCode.isEmpty, false);
        expect(bloc.faceIdEnabled, false);
        expect(bloc.fingerPrintEnabled, false);
      },
    );
  });

  group('on Done without bio metric', () {
    blocTest(
      'on Done without bio metric success state',
      build: () {
        return PinCodeCubit(
          auth: mockLocalAuthentication,
          service: mockLocalStorageService,
          repo: mockPinCodeRepo,
        );
      },
      act: (PinCodeCubit bloc) async {
        when(mockPinCodeRepo.setup('1234', 0, 0))
            .thenAnswer((Invocation realInvocation) async {
          return right(true);
        });

        when(mockLocalStorageService.setFaceIdValue(faceId: false))
            .thenAnswer((Invocation realInvocation) async {
          return;
        });

        when(mockLocalStorageService.setTouchIdValue(touchId: false))
            .thenAnswer((Invocation realInvocation) async {
          return;
        });

        bloc.pinCode = '1234';
        await bloc.onDoneWithoutBiometric();
      },
      expect: () => <TypeMatcher<PinCodeState>>[
        isA<PinCodeOnDoneLoading>(),
        isA<PinCodeLoaded>()
      ],
      verify: (PinCodeCubit bloc) {
        expect(bloc.pinCode.isEmpty, true);
        expect(bloc.faceIdEnabled, false);
        expect(bloc.fingerPrintEnabled, false);
        verify(mockPinCodeRepo.setup('1234', 0, 0)).called(1);
      },
    );

    blocTest(
      'on Done without bio metric failure state',
      build: () {
        return PinCodeCubit(
          auth: mockLocalAuthentication,
          service: mockLocalStorageService,
          repo: mockPinCodeRepo,
        );
      },
      act: (PinCodeCubit bloc) async {
        when(mockPinCodeRepo.setup('1234', 0, 0))
            .thenAnswer((Invocation realInvocation) async {
          return right(true);
        });

        when(mockLocalStorageService.setFaceIdValue(faceId: false))
            .thenThrow(Exception());

        when(mockLocalStorageService.setTouchIdValue(touchId: false))
            .thenAnswer((Invocation realInvocation) async {
          return;
        });

        bloc.pinCode = '1234';
        await bloc.onDoneWithoutBiometric();
      },
      expect: () => <TypeMatcher<PinCodeState>>[
        isA<PinCodeOnDoneLoading>(),
        isA<PinCodeError>()
      ],
      verify: (PinCodeCubit bloc) {
        expect(bloc.pinCode.isEmpty, false);
        expect(bloc.faceIdEnabled, false);
        expect(bloc.fingerPrintEnabled, false);
      },
    );
  });

  group('set face id method testing', () {
    blocTest(
      'set face id success state',
      build: () {
        return PinCodeCubit(
          auth: mockLocalAuthentication,
          service: mockLocalStorageService,
          repo: mockPinCodeRepo,
        );
      },
      act: (PinCodeCubit bloc) async {
        when(mockPinCodeRepo.setup('1234', 1, 0))
            .thenAnswer((Invocation realInvocation) async {
          return right(true);
        });

        when(mockLocalStorageService.setFaceIdValue(faceId: true))
            .thenAnswer((Invocation realInvocation) async {
          return;
        });

        when(mockLocalStorageService.setTouchIdValue(touchId: false))
            .thenAnswer((Invocation realInvocation) async {
          return;
        });

        loggedInUser.pinCode = '1234';
        await bloc.setCurrentFaceId(state: true);
      },
      expect: () => <TypeMatcher<PinCodeState>>[
        isA<BioMetricLoading>(),
        isA<PinCodeInitial>(),
        isA<BiometricChanged>()
      ],
      verify: (PinCodeCubit bloc) {
        expect(bloc.faceIdEnabled, true);
        expect(bloc.fingerPrintEnabled, false);
        verify(mockPinCodeRepo.setup('1234', 1, 0)).called(1);
      },
    );

    blocTest(
      'set face id failure state',
      build: () {
        return PinCodeCubit(
          auth: mockLocalAuthentication,
          service: mockLocalStorageService,
          repo: mockPinCodeRepo,
        );
      },
      act: (PinCodeCubit bloc) async {
        when(mockPinCodeRepo.setup('1234', 0, 0))
            .thenAnswer((Invocation realInvocation) async {
          return right(true);
        });

        when(mockLocalStorageService.setFaceIdValue(faceId: false))
            .thenThrow(Exception());

        bloc.pinCode = '1234';
        await bloc.setCurrentFaceId(state: false);
      },
      expect: () => <TypeMatcher<PinCodeState>>[
        isA<BioMetricLoading>(),
        isA<PinCodeInitial>(),
        isA<BiometricError>(),
      ],
      verify: (PinCodeCubit bloc) {
        expect(bloc.faceIdEnabled, true);
      },
    );
  });

  group('set touch id method testing', () {
    blocTest(
      'set touch id success state',
      build: () {
        return PinCodeCubit(
          auth: mockLocalAuthentication,
          service: mockLocalStorageService,
          repo: mockPinCodeRepo,
        );
      },
      act: (PinCodeCubit bloc) async {
        when(mockPinCodeRepo.setup('1234', 0, 1))
            .thenAnswer((Invocation realInvocation) async {
          return right(true);
        });

        when(mockLocalStorageService.setTouchIdValue(touchId: true))
            .thenAnswer((Invocation realInvocation) async {
          return;
        });

        loggedInUser.pinCode = '1234';
        await bloc.setCurrentFingerPrint(state: true);
      },
      expect: () => <TypeMatcher<PinCodeState>>[
        isA<BioMetricLoading>(),
        isA<PinCodeInitial>(),
        isA<BiometricChanged>()
      ],
      verify: (PinCodeCubit bloc) {
        expect(bloc.faceIdEnabled, false);
        expect(bloc.fingerPrintEnabled, true);
        verify(mockPinCodeRepo.setup('1234', 0, 1)).called(1);
      },
    );

    blocTest(
      'set touch id failure state',
      build: () {
        return PinCodeCubit(
          auth: mockLocalAuthentication,
          service: mockLocalStorageService,
          repo: mockPinCodeRepo,
        );
      },
      act: (PinCodeCubit bloc) async {
        when(mockPinCodeRepo.setup('1234', 0, 0))
            .thenAnswer((Invocation realInvocation) async {
          return right(true);
        });

        when(mockLocalStorageService.setFaceIdValue(faceId: false))
            .thenThrow(Exception());

        bloc.pinCode = '1234';
        await bloc.setCurrentFaceId(state: false);
      },
      expect: () => <TypeMatcher<PinCodeState>>[
        isA<BioMetricLoading>(),
        isA<PinCodeInitial>(),
        isA<BiometricError>(),
      ],
      verify: (PinCodeCubit bloc) {
        expect(bloc.faceIdEnabled, true);
      },
    );
  });
}
