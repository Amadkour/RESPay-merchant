import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/core/public_module/cubit/global_cubit.dart';
import 'package:res_pay_merchant/core/services/dependency_jnjection.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/provider/API/language_api.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/provider/model/language_model.dart';
import 'package:res_pay_merchant/features/dashboard/modules/more/modules/language/provider/repository/language_repository.dart';

import '../api/change_language_values.dart';
import 'change_language_repo.mocks.dart';

@GenerateMocks(<Type>[
  LanguageAPI,
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockLanguageAPI mockLanguageAPI;
  late LanguageRepository repository;
  setUpAll(() {
    mockLanguageAPI = MockLanguageAPI();
    repository = LanguageRepository(languageAPI: mockLanguageAPI);
  });

  group('Change Language repo test', () {
    test('get Languages success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
        statusCode: 200,
        data: getLanguageValues.successfulResponse,
        requestOptions: RequestOptions(
          path: getLanguageValues.path,
        ),
      ));
      when(mockLanguageAPI.getLanguages())
          .thenAnswer((Invocation realInvocation) async => response);

      expect(await repository.getLanguagesRepository(),
          isA<Right<Failure, List<LanguageModel>>>());
    });
    test('set Language success', () async {
      final Either<Failure, Response<Map<String, dynamic>>> response =
          Right<Failure, Response<Map<String, dynamic>>>(
              Response<Map<String, dynamic>>(
        statusCode: 200,
        data: setLanguageValues.successfulResponse,
        requestOptions: RequestOptions(
          path: setLanguageValues.path,
        ),
      ));
      sl.registerLazySingleton(() => GlobalCubit());
      when(mockLanguageAPI.setLanguage(
              locale: setLanguageSuccessBody['locale'] as String))
          .thenAnswer((Invocation realInvocation) async => response);

      expect(
          await repository.setLanguageRepository(
            apiLang: setLanguageSuccessBody['locale'] as String,
          ),
          isA<Right<Failure, Map<String, dynamic>>>());
    });
  });
}
