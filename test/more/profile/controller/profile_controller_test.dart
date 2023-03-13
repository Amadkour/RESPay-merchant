import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/controller/profile_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/model/profile_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/profile/provider/repository/profile_repository.dart';

import '../profile_values.dart';
import 'profile_controller_test.mocks.dart';
@GenerateMocks(<Type>[
  ProfileRepository
])
void main() {
  late ProfileRepository repository;

  setUpAll(() {
    repository = MockProfileRepository();
  });

  group('test group profile cubit', () {
    ///--------reset method testing------///
    blocTest<ProfileCubit, ProfileState>(
      'verify that reset method return success',
      build: () => ProfileCubit(repository),
      act: (ProfileCubit bloc) {
        bloc.reset();
      },
      expect: () => <TypeMatcher<ProfileState>>[],
    );
    blocTest<ProfileCubit, ProfileState>(
      'verify that resetErrors method return success',
      build: () => ProfileCubit(repository),
      act: (ProfileCubit bloc) => bloc.resetErrors(),
      expect: () => <TypeMatcher<ProfileState>>[],
    );
    blocTest<ProfileCubit, ProfileState>(
      'verify that resetFormState method return success',
      build: () => ProfileCubit(repository),
      act: (ProfileCubit bloc) => bloc.resetFormState(),
      expect: () => <TypeMatcher<ProfileState>>[],
    );
    blocTest<ProfileCubit, ProfileState>(
      'verify that goToSaveMode method return success',
      build: () => ProfileCubit(repository),
      act: (ProfileCubit bloc) => bloc.goToSaveMode(),
      expect: () => <TypeMatcher<ProfileState>>[
        isA<IsSaveStateChanged>(),
      ],
    );
    blocTest<ProfileCubit, ProfileState>(
      'verify that cancel method return success',
      build: () => ProfileCubit(repository),
      act: (ProfileCubit bloc) => bloc.cancel(),
      expect: () => <TypeMatcher<ProfileState>>[
        isA<IsSaveStateChanged>(),
      ],
    );
    blocTest<ProfileCubit, ProfileState>(
      'verify that goToEditMode method return success',
      build: () => ProfileCubit(repository),
      act: (ProfileCubit bloc) => bloc.goToEditMode(),
      expect: () => <TypeMatcher<ProfileState>>[
        isA<GoToEditMode>(),
      ],
    );
    blocTest<ProfileCubit, ProfileState>(
      'verify that setCurrentIsReadOnlyState method return success',
      build: () => ProfileCubit(repository),
      act: (ProfileCubit bloc) => bloc.setCurrentIsReadOnlyState(),
      expect: () => <TypeMatcher<ProfileState>>[],
    );
    blocTest<ProfileCubit, ProfileState>(
      'verify that sendSupportRequest method return success',
      build: () {
        when(repository.showProfileRepository()).thenAnswer((Invocation realInvocation) async =>Right<Failure, ParentModel>(ProfileModel()));
        return ProfileCubit(repository);
      },
      act: (ProfileCubit bloc) => bloc.showProfile(),
      expect: () => <TypeMatcher<ProfileState>>[isA<ProfileLoaded>(),],
      verify: (ProfileCubit bloc) => verify(
          repository.showProfileRepository())
          .called(1),
    );
    blocTest<ProfileCubit, ProfileState>(
      'verify that sendSupportRequest method return success',
      build: () {
        when(repository.updateProfileRepository(inputs: updateProfileSuccessInput)).thenAnswer((Invocation realInvocation) async => Right<Failure, ParentModel>(ProfileModel()));
        return ProfileCubit(repository);
      },
      act: (ProfileCubit bloc) => bloc.showProfile(),
      expect: () => <TypeMatcher<ProfileState>>[isA<ProfileLoaded>(),],
      verify: (ProfileCubit bloc) => verify(
          repository.showProfileRepository())
          .called(1),
    );
  });

}
