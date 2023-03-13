import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/provider/model/terms_privacy_about_model.dart';
import 'package:res_pay_merchant/core/res/utils/parse_model/parent_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/controller/terms_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/terms_and_conditions/provider/API/end_point.dart';

import '../../about/controller/about_cubit_test.mocks.dart';

void main() {
  late MockTermPrivacyAboutRepository repository;

  final ApiFailure failure = ApiFailure();
  setUpAll(() {
    repository = MockTermPrivacyAboutRepository();
  });

  group('test Terms cubit', () {
    ///-------- Success init ------///
    blocTest<TermsCubit, TermsState>(
      'onSuccess Test Init',
      build: () {
        when(repository.getTermsPrivacyAboutRepository(endPoint: getTermsPath))
            .thenAnswer((Invocation realInvocation) async =>
            Right<Failure, ParentModel>(TermPrivacyAboutModel()));

        return TermsCubit(repository);
      },
      act: (TermsCubit bloc) {},
      expect: () => <TypeMatcher<TermsState>>[isA<TermsLoaded>()],
      verify: (TermsCubit bloc) => verify(
          repository.getTermsPrivacyAboutRepository(endPoint: getTermsPath))
          .called(1),
    );

    ///-------- Failure init ------///
    blocTest<TermsCubit, TermsState>(
      'Failure init',
      build: () {
        when(repository.getTermsPrivacyAboutRepository(endPoint: getTermsPath))
            .thenAnswer((Invocation realInvocation) async =>
            Left<Failure, ParentModel>(failure));

        return TermsCubit(repository);
      },
      act: (TermsCubit bloc) {},
      expect: () => <TypeMatcher<TermsState>>[isA<TermsCubitFailure>(),isA<TermsLoaded>()],
      verify: (TermsCubit bloc) => verify(
          repository.getTermsPrivacyAboutRepository(endPoint: getTermsPath))
          .called(1),
    );
  });
}
