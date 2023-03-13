import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/controller/gift_cubit/gift_cubit.dart';
import 'package:res_pay_merchant/features/payment/modules/gift/provider/repos/gift_repo/gift_repo.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/created_beneficiary.dart';
import 'package:res_pay_merchant/features/payment/modules/transfer/provider/model/transfer_category.dart';
import 'package:res_pay_merchant/features/payment/view/component/receipt/provider/model/receipt_model.dart';

import '../gift_values.dart';
import 'gift_controller_test.mocks.dart';

@GenerateMocks(<Type>[GiftRepository])
void main() {
  late MockGiftRepository repository;
  final ApiFailure sendGiftFailure =
      ApiFailure(errors: sendGiftFailedResponseWithUserNotFound['errors'] as Map<String, dynamic>);

  final ApiFailure addNewGiftBeneficiaryFailure =
      ApiFailure(errors: addNewGiftBeneficiaryFailedResponseWithUserNotFound['errors'] as Map<String, dynamic>);

  setUpAll(() {
    repository = MockGiftRepository();
  });

  group('test group gift cubit', () {
    ///--------reset method testing------///
    blocTest<GiftCubit, GiftState>(
      'verify that reset method return success',
      build: () => GiftCubit(repository),
      act: (GiftCubit bloc) => bloc.reset(),
      expect: () => <TypeMatcher<GiftState>>[isA<AllFieldsIsClear>()],
    );
    blocTest<GiftCubit, GiftState>(
      'verify that setCurrentTapIndex method return success',
      build: () => GiftCubit(repository),
      act: (GiftCubit bloc) => bloc.setCurrentTapIndex(0),
      expect: () => <TypeMatcher<GiftState>>[
        isA<TapIsChanged>(),
      ],
    );
    blocTest<GiftCubit, GiftState>(
      'onSuccess Test addNewGiftBeneficiary',
      build: () {
        when(repository.addNewGiftBeneficiary(input: giftSuccessInput))
            .thenAnswer((Invocation realInvocation) async => Right<Failure, ParentModel>(CreatedBeneficiaryModel()));
        return GiftCubit(repository);
      },
      act: (GiftCubit bloc) {
        bloc.firstNameController.text = "hussein";
        bloc.lastNameController.text = "hamed";
        bloc.phoneNumberController.text = "050505055535";
        bloc.addNewGiftBeneficiary();
      },
      expect: () => <TypeMatcher<GiftState>>[isA<GiftLoadingState>(), isA<GiftBeneficiaryInitiated>()],
      verify: (GiftCubit bloc) => verify(repository.addNewGiftBeneficiary(input: giftSuccessInput)).called(1),
    );

    blocTest<GiftCubit, GiftState>(
      'onFail Test addNewGiftBeneficiary',
      build: () {
        when(repository.addNewGiftBeneficiary(input: giftFailureInput))
            .thenAnswer((Invocation realInvocation) async => Left<Failure, ParentModel>(addNewGiftBeneficiaryFailure));
        return GiftCubit(repository);
      },
      act: (GiftCubit bloc) {
        bloc.firstNameController.text = "hussein";
        bloc.lastNameController.text = "hamed";
        bloc.addNewGiftBeneficiary();
      },
      expect: () => <TypeMatcher<GiftState>>[isA<GiftLoadingState>(), isA<AddNewGiftBeneficiaryErrorState>()],
      verify: (GiftCubit bloc) => verify(repository.addNewGiftBeneficiary(input: giftFailureInput)).called(1),
    );

    blocTest<GiftCubit, GiftState>(
      'onSuccess Test sendGift',
      build: () {
        when(repository.sendGift(input: sendGiftSuccessInput)).thenAnswer((Invocation realInvocation) async =>
            right(ReceiptModel.fromJson(sendGiftSuccessResponse['data'] as Map<String, dynamic>, 'transfer')));
        return GiftCubit(repository);
      },
      act: (GiftCubit bloc) {
        bloc.amountController.text = "100";
        bloc.noteController.text = "test";
        bloc.currentCategory = const TransferCategoryModel(uuid: "32423432432432");
        bloc.currentPurpose = "test";
        bloc.sendGift("34543534534sdfsdfswdfwsf");
      },
      expect: () => <TypeMatcher<GiftState>>[isA<GiftLoadingState>(), isA<GiftSendSate>()],
      verify: (GiftCubit bloc) => verify(repository.sendGift(input: sendGiftSuccessInput)).called(1),
    );

    blocTest<GiftCubit, GiftState>(
      'onFail Test sendGift',
      build: () {
        when(repository.sendGift(input: sendGiftFailureInput))
            .thenAnswer((Invocation realInvocation) async => left(sendGiftFailure));

        return GiftCubit(repository);
      },
      act: (GiftCubit bloc) {
        bloc.noteController.text = "test";
        bloc.currentCategory = const TransferCategoryModel(uuid: "32423432432432");
        bloc.currentPurpose = "test";
        bloc.sendGift("34543534534sdfsdfswdfwsf");
      },
      expect: () => <TypeMatcher<GiftState>>[isA<GiftLoadingState>(), isA<GiftSendError>()],
      verify: (GiftCubit bloc) => verify(repository.sendGift(input: sendGiftFailureInput)).called(1),
    );
    //////////////////////////////////////////////////////////


    blocTest<GiftCubit, GiftState>(
      'verify that resetStateAfterNavigate method',
      build: () => GiftCubit(repository),
      act: (GiftCubit bloc) {
        bloc.resetStateAfterNavigate();
      },
      expect: () => <TypeMatcher<GiftState>>[
        isA<NewGiftInitial>(),
      ],
    );
  });
}
