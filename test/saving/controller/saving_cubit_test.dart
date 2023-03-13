import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/controller/saving_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/model/role_model.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/respository/role_repository.dart';
import 'package:res_pay_merchant/features/payment/modules/saving/provider/respository/saving_repository.dart';

import '../provider/role_values.dart';
import '../provider/saving_values.dart';
import 'saving_cubit_test.mocks.dart';

@GenerateMocks(<Type>[RoleRepository, SavingRepository])
void main() {
  late MockRoleRepository roleRepository;
  late MockSavingRepository savingRepository;

  // final ApiFailure failure = ApiFailure(message: "server error");
  setUpAll(() {
    roleRepository = MockRoleRepository();
    savingRepository = MockSavingRepository();
  });

  group('test Saving cubit', () {
    ///--------init ------///
    group('Init testing', () {
      ///--------On Success init ------///
      blocTest<SavingCubit, SavingState>(
        'Test init',
        build: () => SavingCubit(roleRepository, savingRepository),
        act: (SavingCubit bloc) {},
        expect: () => <TypeMatcher<SavingState>>[isA<SavingLoadedState>()],
      );

      ///--------On Failure init ------///
      blocTest<SavingCubit, SavingState>(
        'Test init',
        build: () => SavingCubit(roleRepository, savingRepository),
        act: (SavingCubit bloc) {},
        expect: () => <TypeMatcher<SavingState>>[isA<SavingLoadedState>()],
      );
    });

    ///-------- onChangeSwitcherValue ------///
    blocTest<SavingCubit, SavingState>(
      'Test onChangeSwitcherValue',
      build: () {
        when(savingRepository.toggleSavingRepository()).thenAnswer((Invocation
                realInvocation) async =>
            Right<Failure, Map<String, dynamic>>(toggleSavingSuccessResponse));

        return SavingCubit(roleRepository, savingRepository);
      },
      act: (SavingCubit bloc) => bloc.onChangeSwitcherValue(newValue: true),
      expect: () => <TypeMatcher<SavingState>>[
        isA<SavingLoadedState>(),
        isA<SavingChangeSwitcherState>()
      ],
    );

    ///-------- deleteRole ------///
    blocTest<SavingCubit, SavingState>(
      'Test deleteRole',
      build: () {
        when(roleRepository.deleteRoleRepository(
                roleUUID: deleteRoleSuccessBody['uuid']))
            .thenAnswer((Invocation realInvocation) async =>
                Right<Failure, Map<String, dynamic>>(
                    toggleSavingSuccessResponse));

        return SavingCubit(roleRepository, savingRepository);
      },
      act: (SavingCubit bloc) {
        bloc.roles = <RoleModel>[RoleModel(), RoleModel()];

        /// Assign the same value for mocking to the function
        bloc.roles[1].uuid = deleteRoleSuccessBody['uuid'];
        bloc.deleteRole(index: 1);
      },
      expect: () => <TypeMatcher<SavingState>>[
        isA<SavingDeleteRoleLoadingState>(),
        isA<SavingLoadedState>(),
        isA<SavingDeleteRoleLoadedState>(),
      ],
    );

    ///-------- toggleRole ------///
    blocTest<SavingCubit, SavingState>(
      'Test toggleRole',
      build: () {
        when(roleRepository.toggleRoleRepository(
                roleUUID: toggleRoleSuccessBody['uuid']))
            .thenAnswer((Invocation realInvocation) async =>
                Right<Failure, Map<String, dynamic>>(
                    toggleSavingSuccessResponse));

        return SavingCubit(roleRepository, savingRepository);
      },
      act: (SavingCubit bloc) {
        bloc.roles = <RoleModel>[RoleModel(), RoleModel()];

        /// Assign the same value for mocking to the function
        bloc.roles[1].uuid = toggleRoleSuccessBody['uuid'];
        bloc.toggleRole(index: 1, onSuccess: () {});
      },
      expect: () => <TypeMatcher<SavingState>>[
        isA<SavingToggleRoleLoadingState>(),
        isA<SavingLoadedState>(),
        isA<SavingToggleRoleFailure>(),
      ],
    );

    ///-------- addRole ------///
    blocTest<SavingCubit, SavingState>(
      'Test addRole',
      build: () {
        when(roleRepository.addRoleRepository(
                from: addRoleSuccessBody['from'] as double,
                value: addRoleSuccessBody['value'] as double,
                to: addRoleSuccessBody['to'] as double))
            .thenAnswer((Invocation realInvocation) async =>
                Right<Failure, Map<String, dynamic>>(addRoleSuccessResponse));

        return SavingCubit(roleRepository, savingRepository);
      },
      act: (SavingCubit bloc) {
        /// Assign the same value for mocking to the function

        bloc.toController.text = addRoleSuccessBody['to'].toString();
        bloc.fromController.text = addRoleSuccessBody['from'].toString();
        bloc.saveController.text = addRoleSuccessBody['value'].toString();

        bloc.addRole(onBack: () {});
      },
      expect: () => <TypeMatcher<SavingState>>[
        isA<SavingAddNewRoleLoading>(),
        isA<SavingLoadedState>(),
        isA<SavingAddNewRoleLoaded>(),
      ],
    );

    ///-------- UpdateRole ------///
    blocTest<SavingCubit, SavingState>(
      'Test UpdateRole',
      build: () {
        when(roleRepository.updateRoleRepository(
                from: updateRoleSuccessBody['from'] as double,
                value: updateRoleSuccessBody['value'] as double,
                to: updateRoleSuccessBody['to'] as double,
                roleUUID: updateRoleSuccessBody['uuid'] as String,
                isActive: updateRoleSuccessBody['is_active'] as int))
            .thenAnswer((Invocation realInvocation) async =>
                Right<Failure, Map<String, dynamic>>(
                    updateRoleSuccessResponse));

        return SavingCubit(roleRepository, savingRepository);
      },
      act: (SavingCubit bloc) {
        /// Assign the same value for mocking to the function

        bloc.roles.add(RoleModel(
            isActive: (updateRoleSuccessBody['is_active'] as int) != 0,
            uuid: updateRoleSuccessBody['uuid'] as String));

        bloc.toController.text = updateRoleSuccessBody['to'].toString();
        bloc.fromController.text = updateRoleSuccessBody['from'].toString();
        bloc.saveController.text = updateRoleSuccessBody['value'].toString();

        bloc.updateRole(onBack: () {}, index: 0);
      },
      expect: () => <TypeMatcher<SavingState>>[
        isA<SavingUpdateRoleLoading>(),
        isA<SavingLoadedState>(),
        isA<SavingUpdateRoleLoaded>(),
      ],
    );

    ///-------- addMoney ------///
    blocTest<SavingCubit, SavingState>(
      'Test addMoney',
      build: () {
        when(savingRepository.addMoneyRepository(1000)).thenAnswer(
            (Invocation realInvocation) async =>
                Right<Failure, Map<String, dynamic>>(
                    withdrawDepositSuccessResponse));

        return SavingCubit(roleRepository, savingRepository);
      },
      act: (SavingCubit bloc) {
        bloc.amountController.text = "1000";

        bloc.addMoney(onBack: () {});
      },
      expect: () => <TypeMatcher<SavingState>>[
        isA<SavingButtonLoadingState>(),
        isA<SavingLoadedState>(),
        isA<SavingButtonLoadedState>(),
      ],
    );

    ///-------- Withdraw ------///
    blocTest<SavingCubit, SavingState>(
      'Test Withdraw',
      build: () {
        when(savingRepository.withdraw(1000)).thenAnswer(
            (Invocation realInvocation) async =>
                Right<Failure, Map<String, dynamic>>(
                    withdrawDepositSuccessResponse));

        return SavingCubit(roleRepository, savingRepository);
      },
      act: (SavingCubit bloc) {
        /// initialize variables
        bloc.amountController.text = "1000";
        bloc.totalMoney = 20000;

        bloc.withdraw(onBack: () {});
      },
      expect: () => <TypeMatcher<SavingState>>[
        isA<SavingButtonLoadingState>(),
        isA<SavingLoadedState>(),
        isA<SavingButtonLoadedState>(),
      ],
    );
  });
}
