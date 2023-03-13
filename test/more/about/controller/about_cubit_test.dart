import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/provider/model/terms_privacy_about_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/about/controller/about_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/API/end_point.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/repository/terms_privacy_about_repository.dart';

import 'about_cubit_test.mocks.dart';

@GenerateMocks(<Type>[
  TermPrivacyAboutRepository,
])
void main() {
  late MockTermPrivacyAboutRepository repository;

  final ApiFailure failure = ApiFailure();
  setUpAll(() {
    repository = MockTermPrivacyAboutRepository();
  });

  group('test About cubit', () {
    ///-------- Success init ------///
    blocTest<AboutCubit, AboutState>(
      'onSuccess Test Init',
      build: () {
        when(repository.getTermsPrivacyAboutRepository(endPoint: getAboutPath))
            .thenAnswer((Invocation realInvocation) async =>
                Right<Failure, ParentModel>(TermPrivacyAboutModel()));

        return AboutCubit(repository);
      },
      act: (AboutCubit bloc) {},
      expect: () => <TypeMatcher<AboutState>>[isA<AboutLoaded>()],
      verify: (AboutCubit bloc) => verify(
              repository.getTermsPrivacyAboutRepository(endPoint: getAboutPath))
          .called(1),
    );

    ///-------- Failure init ------///
    blocTest<AboutCubit, AboutState>(
      'Failure init',
      build: () {
        when(repository.getTermsPrivacyAboutRepository(endPoint: getAboutPath))
            .thenAnswer((Invocation realInvocation) async =>
                Left<Failure, ParentModel>(failure));

        return AboutCubit(repository);
      },
      act: (AboutCubit bloc) {},
      expect: () => <TypeMatcher<AboutState>>[isA<AboutFailure>(),isA<AboutLoaded>()],
      verify: (AboutCubit bloc) => verify(
              repository.getTermsPrivacyAboutRepository(endPoint: getAboutPath))
          .called(1),
    );
  });
}
