import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/controller/bank_name_controller/bank_name_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/provider/model/bank_name.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/provider/model/bank_names_model.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/provider/repos/bank_name/bank_name_repo.dart';

import 'bank_name_controller_test.mocks.dart';

@GenerateMocks(<Type>[BankNameRemoteRepo])
void main() {
  late MockBankNameRemoteRepo repository;
  final ApiFailure bankNameFailure = ApiFailure(errors: <String, dynamic>{});

  setUpAll(() {
    repository = MockBankNameRemoteRepo();
  });

  group('test group bank name cubit', () {
    ///--------reset method testing------///
    blocTest<BankNameCubit, BankNameState>(
      'verify that reset method return success',
      build: () => BankNameCubit(repository),
      act: (BankNameCubit bloc) => bloc.reset(),
      expect: () => <TypeMatcher<BankNameState>>[
        isA<BankNameValueChanged>(),
      ],
    );
    blocTest<BankNameCubit, BankNameState>(
      'verify that reset method return success',
      build: () => BankNameCubit(repository),
      act: (BankNameCubit bloc) => bloc.setCurrentBankName(BankName()),
      expect: () => <TypeMatcher<BankNameState>>[
        isA<BankNameValueChanged>(),
      ],
    );
    blocTest<BankNameCubit, BankNameState>(
      'on success Test getAllBankNames',
      build: () {
        when(repository.getAllBankNames()).thenAnswer(
            (Invocation realInvocation) async =>
                Right<Failure, ParentModel>(BankNamesModel()));
        return BankNameCubit(repository);
      },
      act: (BankNameCubit bloc) {
        bloc.getBankNames();
      },
      expect: () => <TypeMatcher<BankNameState>>[
        isA<BankNamesLoadingState>(),
        isA<BankNameLoadedState>(),
      ],
      verify: (BankNameCubit bloc) =>
          verify(repository.getAllBankNames()).called(1),
    );

    blocTest<BankNameCubit, BankNameState>(
      'onFail Test getAllBankNames',
      build: () {
        when(repository.getAllBankNames()).thenAnswer(
            (Invocation realInvocation) async =>
                Left<Failure, ParentModel>(bankNameFailure));
        return BankNameCubit(repository);
      },
      act: (BankNameCubit bloc) {
        bloc.getBankNames();
      },
      expect: () => <TypeMatcher<BankNameState>>[
        isA<BankNamesLoadingState>(),
        isA<BankNameErrorState>(),
      ],
      verify: (BankNameCubit bloc) =>
          verify(repository.getAllBankNames()).called(1),
    );
  });
}
