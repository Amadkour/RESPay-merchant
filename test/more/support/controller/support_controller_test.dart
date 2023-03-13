import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/controller/support_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/provider/model/support_request_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/support/provider/repo/support_repo.dart';

import '../support_values.dart';
import 'support_controller_test.mocks.dart';
@GenerateMocks(<Type>[
  SupportRepository
])
void main() {
  late MockSupportRepository repository;
  final ApiFailure addNewSupportIssueFailure = ApiFailure(

      errors: addNewSupportIssueInFailedResponse['errors'] as Map<String, dynamic>);
  setUpAll(() {
    repository = MockSupportRepository();
  });

  group('test group support cubit', () {
    ///--------reset method testing------///
    blocTest<SupportCubit, SupportState>(
      'verify that reset method return success',
      build: () => SupportCubit(repository),
      act: (SupportCubit bloc) => bloc.reset(),
      expect: () => <TypeMatcher<SupportState>>[],
    );
    blocTest<SupportCubit, SupportState>(
      'onSuccess Test sendSupportRequest',
      build: () {
        when(repository.sendSupportRequest(input:<String,dynamic>{
          "full_name": "hussein hamed",
          "email": "hussein@gmail.com",
          "message": "test issue",
        }))
            .thenAnswer((Invocation realInvocation) async =>
            Right<Failure, ParentModel>(SupportResponseModel()));
        return SupportCubit(repository);
      },
      act: (SupportCubit bloc) {
        bloc.firstNameController.text="hussein hamed";
        bloc.emailController.text="hussein@gmail.com";
        bloc.supportController.text="test issue";
        bloc.sendIssue();
      },
      expect: () => <TypeMatcher<SupportState>>[
        isA<SupportLoadingState>(),
        isA<SupportSentIssueDone>()
      ],
      verify: (SupportCubit bloc) => verify(repository.sendSupportRequest(input:sendIssueSuccessInput)).called(1),
    );
    blocTest<SupportCubit, SupportState>(
      'onFail Test sendSupportRequest',
      build: () {
        when(repository.sendSupportRequest(input:sendIssueSuccessInput))
            .thenAnswer((Invocation realInvocation) async =>
            Left<Failure, ParentModel>(addNewSupportIssueFailure));

        return SupportCubit(repository);
      },
      act: (SupportCubit bloc) {
        bloc.firstNameController.text="";
        bloc.emailController.text="hussein@gmail.com";
        bloc.supportController.text="test issue";
        bloc.sendIssue();
      },
      expect: () => <TypeMatcher<SupportState>>[
        isA<SupportLoadingState>(),
        isA<SupportErrorState>()
      ],
      verify: (SupportCubit bloc) => verify(repository.sendSupportRequest(input:sendIssueFailureInput)).called(1),
    );
  });
}
