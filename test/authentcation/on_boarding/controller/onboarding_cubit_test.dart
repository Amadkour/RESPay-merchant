import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/features/authentication/modules/onboarding/controller/on_boarding_controller_cubit.dart';

import 'onboarding_cubit_test.mocks.dart';

@GenerateMocks(<Type>[LocalStorageService])
void main() {
  late MockLocalStorageService mockLocalStorageService;

  setUpAll(() {
    mockLocalStorageService = MockLocalStorageService();
  });
  group('onboarding cubit test', () {
    blocTest(
      'test change index function',
      act: (OnBoardingControllerCubit bloc) => bloc.onChangeIndex(1),
      build: () => OnBoardingControllerCubit(mockLocalStorageService),
      expect: () => <TypeMatcher<OnBoardingControllerState>>[isA<OnBoardingControllerChangeIndexState>()],
      verify: (OnBoardingControllerCubit bloc) => bloc.index == 1,
    );

    blocTest(
      "test install function ",
      build: () => OnBoardingControllerCubit(mockLocalStorageService),
      act: (OnBoardingControllerCubit bloc) {
        when(mockLocalStorageService.writeKey(any, true)).thenAnswer((Invocation realInvocation) async {
          return;
        });

        bloc.install();
      },
      verify: (OnBoardingControllerCubit bloc) => verify(bloc.install()).called(1),
    );
  });
}
