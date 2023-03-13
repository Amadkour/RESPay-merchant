import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/request/controller/request_cubit/request_state.dart';
import 'package:res_pay_merchant/features/payment/modules/request/provider/repos/request_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/created_beneficiary.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

import '../request_values.dart';
import '../send_money_request_values.dart';
import 'request_controller_test.mocks.dart';

@GenerateMocks(<Type>[RequestRemoteRepo])
void main() {
  late MockRequestRemoteRepo repository;
  final ApiFailure addNewRequestBeneficiaryFailure =
      ApiFailure(errors: addNewRequestBeneficiaryFailedResponseWithUserNotFound['errors'] as Map<String, dynamic>);
  final ApiFailure sendRequestFailure =
      ApiFailure(errors: sendMoneyFailedResponseWithUserNotFound['errors'] as Map<String, dynamic>);
  setUpAll(() {
    repository = MockRequestRemoteRepo();
  });

  group('test group request cubit', () {
    ///--------reset method testing------///

    blocTest<RequestCubit, RequestState>(
      'onSuccess Test addNewRequestBeneficiary',
      build: () {
        when(repository.addNewRequestBeneficiary(input: <String, dynamic>{
          "phone_number": "0500099991",
          "type": "internal",
          "method": "Request Money",
          "first_name": "HUSSEIN",
          "last_name": "HAMED",
        })).thenAnswer((Invocation realInvocation) async => Right<Failure, ParentModel>(CreatedBeneficiaryModel()));
        return RequestCubit(repository);
      },
      act: (RequestCubit bloc) {
        bloc.firstNameController.text = "HUSSEIN";
        bloc.lastNameController.text = "HAMED";
        bloc.phoneNumberController.text = "0500099991";
        bloc.addNewRequestBeneficiary();
      },
      expect: () => <TypeMatcher<RequestState>>[
        isA<RequestLoadingState>(),
        isA<RequestDoneNavigateToTransferMoney>(),
      ],
      verify: (RequestCubit bloc) => verify(repository.addNewRequestBeneficiary(input: <String, dynamic>{
        "phone_number": "0500099991",
        "type": "internal",
        "method": "Request Money",
        "first_name": "HUSSEIN",
        "last_name": "HAMED",
      })).called(1),
    );

    blocTest<RequestCubit, RequestState>(
      'onFail Test addNewRequestBeneficiary',
      build: () {
        when(repository.addNewRequestBeneficiary(input: <String, dynamic>{
          "phone_number": "0500099888",
          "type": "internal",
          "method": "Request Money",
          "first_name": "HUSSEIN",
          "last_name": "HAMED",
        })).thenAnswer(
            (Invocation realInvocation) async => Left<Failure, ParentModel>(addNewRequestBeneficiaryFailure));
        return RequestCubit(repository);
      },
      act: (RequestCubit bloc) {
        bloc.firstNameController.text = "HUSSEIN";
        bloc.lastNameController.text = "HAMED";
        bloc.phoneNumberController.text = "0500099888";
        bloc.addNewRequestBeneficiary();
      },
      expect: () => <TypeMatcher<RequestState>>[
        isA<RequestLoadingState>(),
        isA<AddNewRequestBeneficiaryErrorState>(),
      ],
      verify: (RequestCubit bloc) => verify(repository.addNewRequestBeneficiary(input: <String, dynamic>{
        "phone_number": "0500099888",
        "type": "internal",
        "method": "Request Money",
        "first_name": "HUSSEIN",
        "last_name": "HAMED",
      })).called(1),
    );

    ////////////////////////////// test requestMoney //////////////////////////////

    blocTest<RequestCubit, RequestState>(
      'onSuccess Test requestMoney',
      build: () {
        when(repository.requestMoney(input: sendMoneySuccessInput)).thenAnswer((Invocation realInvocation) async =>
            right(ReceiptModel.fromJson(sendMoneySuccessResponse['data'] as Map<String, dynamic>, 'request')));
        return RequestCubit(repository);
      },
      act: (RequestCubit bloc) {
        bloc.amountController.text = "100";
        bloc.noteController.text = "test";
        bloc.currentCategory = "32423432432432";
        bloc.phoneNumberController.text = "0500099991";
        bloc.sendRequestMoney("345345345-345345-345324d");
      },
      expect: () => <TypeMatcher<RequestState>>[
        isA<RequestLoadingState>(),
        isA<RequestSendSate>(),
      ],
      verify: (RequestCubit bloc) => verify(repository.requestMoney(input: sendMoneySuccessInput)).called(1),
    );

    blocTest<RequestCubit, RequestState>(
      'onFail Test requestMoney',
      build: () {
        when(repository.requestMoney(input: sendMoneySuccessInput))
            .thenAnswer((Invocation realInvocation) async => left(sendRequestFailure));
        return RequestCubit(repository);
      },
      act: (RequestCubit bloc) {
        bloc.amountController.text = "";
        bloc.noteController.text = "test";
        bloc.currentCategory = "32423432432432";
        bloc.sendRequestMoney("345345345-345345-345324d");
      },
      expect: () => <TypeMatcher<RequestState>>[
        isA<RequestLoadingState>(),
        isA<RequestMoneyErrorState>(),
      ],
      verify: (RequestCubit bloc) => verify(repository.requestMoney(input: sendMoneyFailureInput)).called(1),
    );

    blocTest<RequestCubit, RequestState>(
      'verify that reset method return success',
      build: () => RequestCubit(repository),
      act: (RequestCubit bloc) => bloc.reset(),
      expect: () => <TypeMatcher<RequestState>>[isA<ResetRequestFields>()],
    );

    blocTest<RequestCubit, RequestState>(
      'verify that resetStateAfterNavigate method return success',
      build: () => RequestCubit(repository),
      act: (RequestCubit bloc) => bloc.resetStateAfterNavigate(),
      expect: () => <TypeMatcher<RequestState>>[
        isA<RequestInitial>(),
      ],
    );
  });
}
