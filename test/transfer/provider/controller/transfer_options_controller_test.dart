import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/controller/transfer_options/transfer_options_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer_options_model.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/repos/transfer_options/transfer_options_repo.dart';

import 'transfer_options_controller_test.mocks.dart';

@GenerateMocks(<Type>[
  TransferOptionsRepo
])
void main() {
  late MockTransferOptionsRepo repository;
  final ApiFailure getDataFailure = ApiFailure(
      errors: <String, dynamic>{});

  setUpAll(() {
    repository = MockTransferOptionsRepo();
  });
  group('test group TransferOptions Cubit', () {
    blocTest<TransferOptionsCubit, TransferOptionsState>(
      'onSuccess Test getData',
      build: () {
        when(repository.get())
            .thenAnswer((Invocation realInvocation) async =>
            Right<Failure, ParentModel>(TransferOptionsModel()));
        return TransferOptionsCubit(repository);
      },
      act: (TransferOptionsCubit bloc) {
        bloc.get();
      },
      expect: () => <TypeMatcher<TransferOptionsState>>[
        isA<TransferOptionsLoadingState>(),
        isA<TransferOptionsLoadedState>(),
        isA<TransferOptionsLoadedState>()
      ],
    );
    blocTest<TransferOptionsCubit, TransferOptionsState>(
      'onFail Test getData',
      build: () {
        when(repository.get())
            .thenAnswer((Invocation realInvocation) async =>
            Left<Failure, ParentModel>(getDataFailure));
        return TransferOptionsCubit(repository);
      },
      act: (TransferOptionsCubit bloc) {
        bloc.get();
      },
      expect: () => <TypeMatcher<TransferOptionsState>>[
        isA<TransferOptionsLoadingState>(),
        isA<TransferOptionsErrorState>(),
        isA<TransferOptionsErrorState>()
      ],
    );

    ///--------setCurrentTapIndex method testing------///
    blocTest<TransferOptionsCubit, TransferOptionsState>(
      'verify that setCurrentTapIndex method return success',
      build: () => TransferOptionsCubit(repository),
      act: (TransferOptionsCubit bloc) => bloc.reset(),
      expect: () => <TypeMatcher<TransferOptionsState>>[
        isA<TransferOptionsErrorState>()
      ],
    );
    blocTest<TransferOptionsCubit, TransferOptionsState>(
      'verify that setCurrentPurpose method return success',
      build: () => TransferOptionsCubit(repository),
      act: (TransferOptionsCubit bloc) => bloc.setCurrentPurpose("test"),
      expect: () => <TypeMatcher<TransferOptionsState>>[
        isA<TransferTypeItemChosen>(),
        isA<TransferOptionsErrorState>()
      ],
    );
    blocTest<TransferOptionsCubit, TransferOptionsState>(
      'verify that setCurrentCategory method return success',
      build: () => TransferOptionsCubit(repository),
      act: (TransferOptionsCubit bloc) => bloc.setCurrentCategory("test"),
      expect: () => <TypeMatcher<TransferOptionsState>>[
        isA<TransferTypeItemChosen>(),
        isA<TransferOptionsErrorState>()
      ],
    );
    blocTest<TransferOptionsCubit, TransferOptionsState>(
      'verify that setCurrentMethodType method return success',
      build: () => TransferOptionsCubit(repository),
      act: (TransferOptionsCubit bloc) => bloc.setCurrentMethodType("RES App"),
      expect: () => <TypeMatcher<TransferOptionsState>>[
        isA<TransferTypeItemChosen>(),
        isA<TransferOptionsErrorState>()
      ],
    );

  });
}
