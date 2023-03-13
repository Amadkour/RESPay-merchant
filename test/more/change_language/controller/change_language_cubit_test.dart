import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/core/services/local_storage_service.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/controller/language_cubit.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/provider/model/language_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/provider/repository/language_repository.dart';

import '../../../core/api_connection_mocks.mocks.dart';
import 'change_language_cubit_test.mocks.dart';

@GenerateMocks(<Type>[
  LanguageRepository,
  LocalStorageService,
])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late MockLanguageRepository mockLanguageRepository;
  late MockLocalStorageService mockLocalStorageService;
  late MockGlobalCubit mockGlobalCubit;
  setUpAll(() {
    mockLanguageRepository = MockLanguageRepository();
    mockLocalStorageService = MockLocalStorageService();
    mockGlobalCubit = MockGlobalCubit();

    when(mockLanguageRepository.getLanguagesRepository()).thenAnswer(
        (Invocation realInvocation) async =>
            const Right<Failure, List<LanguageModel>>(<LanguageModel>[]));
    when(mockLocalStorageService.readString('lang'))
        .thenAnswer((Invocation realInvocation) => 'en');
  });

  blocTest<LanguageCubit, LanguageState>(
    'toggle Language test',
    build: () => LanguageCubit(),
    act: (LanguageCubit bloc) => bloc.toggleLanguage("en"),
    expect: () => <TypeMatcher<LanguageState>>[
      isA<LanguageChangeRadioValue>(),
      isA<LanguageLoaded>(),
    ],
  );

  blocTest<LanguageCubit, LanguageState>(
    'onTapButton test',
    build: () {
      when(mockLanguageRepository.setLanguageRepository(apiLang: "en"))
          .thenAnswer((Invocation realInvocation) async =>
              const Right<Failure, Map<String, dynamic>>(<String, dynamic>{}));
      sl.registerLazySingleton(() => GlobalCubit());

      return LanguageCubit();
    },
    act: (LanguageCubit bloc) async {
      bloc.toggleLanguage("en");
      await bloc.onTapButton();
    },
    expect: () => <TypeMatcher<LanguageState>>[
      isA<LanguageChangeRadioValue>(),
      isA<LanguageChangeLanguageLoading>(),
      isA<LanguageLoaded>(),
      isA<LanguageChangeLanguageLoaded>(),
    ],
  );
}
