import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/provider/model/terms_privacy_about_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/privacy/controller/privacy_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/API/end_point.dart';

import '../../about/controller/about_cubit_test.mocks.dart';

void main() {
  late MockTermPrivacyAboutRepository repository;

  final ApiFailure failure = ApiFailure();
  setUpAll(() {
    repository = MockTermPrivacyAboutRepository();
  });

  group('test privacy cubit', () {
    ///-------- Success init ------///
    blocTest<PrivacyCubit, PrivacyState>(
      'onSuccess Test Init',
      build: () {
        when(repository.getTermsPrivacyAboutRepository(endPoint: getPrivacyPath))
            .thenAnswer((Invocation realInvocation) async =>
            Right<Failure, ParentModel>(TermPrivacyAboutModel()));

        return PrivacyCubit(repository);
      },
      act: (PrivacyCubit bloc) {},
      expect: () => <TypeMatcher<PrivacyState>>[isA<PrivacyLoaded>()],
      verify: (PrivacyCubit bloc) => verify(
          repository.getTermsPrivacyAboutRepository(endPoint: getPrivacyPath))
          .called(1),
    );

    ///-------- Failure init ------///
    blocTest<PrivacyCubit, PrivacyState>(
      'Failure init',
      build: () {
        when(repository.getTermsPrivacyAboutRepository(endPoint: getPrivacyPath))
            .thenAnswer((Invocation realInvocation) async =>
            Left<Failure, ParentModel>(failure));

        return PrivacyCubit(repository);
      },
      act: (PrivacyCubit bloc) {},
      expect: () => <TypeMatcher<PrivacyState>>[isA<PrivacyChangeFailure>(),isA<PrivacyLoaded>()],
      verify: (PrivacyCubit bloc) => verify(
          repository.getTermsPrivacyAboutRepository(endPoint: getPrivacyPath))
          .called(1),
    );
  });
}
