import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/API/login_api.dart';
import 'package:res_pay_merchant/features/authentication/modules/login/provider/repository/login_repository.dart';

import '../login_values.dart';
import 'login_repository_test.mocks.dart';

@GenerateMocks(<Type>[
  LoginApi,
])
void main() {
  late LoginRepository loginRepository;
  late MockLoginApi mockLoginApi;

  setUpAll(() {
    mockLoginApi = MockLoginApi();
    loginRepository = LoginRepository(loginApi: mockLoginApi);
  });

  group('Login Repository test', () {
    test('test on success', () async {
      when(mockLoginApi.loginAPI(loginInput)).thenAnswer((Invocation realInvocation) async {
        return right(Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(
            path: loginValues.path,
          ),
          data: loginValues.successfulResponse,
        ));
      });

      final Either<Failure, Map<String, dynamic>> result = await loginRepository.loginRepository(loginInput);

      expect(result, isA<Right<Failure, Map<String, dynamic>>>());

      final Object data = result.fold((Failure l) => l, (Map<String, dynamic> r) => r);
      expect(data, equals(loginValues.successfulResponse));
    });

    test(
      "test on failure",
      () async {
        when(mockLoginApi.loginAPI(loginInput)).thenAnswer((Invocation realInvocation) async {
          return left(ApiFailure());
        });

        final Either<Failure, Map<String, dynamic>> result = await loginRepository.loginRepository(failureLoginInput);

        expect(result, isA<Left<Failure, Map<String, dynamic>>>());
      },
    );
  });
}
