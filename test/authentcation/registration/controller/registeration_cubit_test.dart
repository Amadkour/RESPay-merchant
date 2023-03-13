import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/registration/controller/register_cubit.dart';
import 'package:res_pay_merchant/features/authentication/modules/registration/providers/repository/registeration_repository.dart';

import '../provider/registration_values.dart';
import 'registeration_cubit_test.mocks.dart';

@GenerateMocks(<Type>[RegistrationRepository])
void main() {
  late MockRegistrationRepository mockRepo;
  setUpAll(() {
    mockRepo = MockRegistrationRepository();
  });
  blocTest(
    "test registration success",
    build: () => RegisterCubit(mockRepo),
    setUp: () {
      when(mockRepo.register(registrationInputs)).thenAnswer((Invocation realInvocation) async {
        return right('7159');
      });
    },
    act: (RegisterCubit bloc) {
      bloc.id = successInput['identity_id'] as String;
      bloc.birthDateController.text = successInput['dob'] as String;
      bloc.fullName = successInput['full_name'] as String;
      bloc.email = successInput['email'] as String;
      bloc.phone = successInput['phone_number'] as String;
      bloc.password = successInput['password'] as String;
      bloc.passwordConfirmation = successInput['password_confirmation'] as String;

      return bloc.register();
    },
    expect: () => <TypeMatcher<RegisterState>>[isA<RegisterLoading>(), isA<RegisterLoaded>()],
    verify: (RegisterCubit bloc) => verify(mockRepo.register(registrationInputs)).called(1),
  );

  blocTest(
    "test registration failure",
    build: () => RegisterCubit(mockRepo),
    setUp: () {
      when(mockRepo.register(registrationInputs)).thenAnswer((Invocation realInvocation) async {
        return left(ApiFailure());
      });
    },
    act: (RegisterCubit bloc) {
      bloc.id = successInput['identity_id'] as String;
      bloc.birthDateController.text = successInput['dob'] as String;
      bloc.fullName = successInput['full_name'] as String;
      bloc.email = successInput['email'] as String;
      bloc.phone = successInput['phone_number'] as String;
      bloc.password = successInput['password'] as String;
      bloc.passwordConfirmation = successInput['password_confirmation'] as String;

      return bloc.register();
    },
    expect: () => <TypeMatcher<RegisterState>>[isA<RegisterLoading>(), isA<RegisterErrorState>()],
    verify: (RegisterCubit bloc) => verify(mockRepo.register(registrationInputs)).called(1),
  );
}
