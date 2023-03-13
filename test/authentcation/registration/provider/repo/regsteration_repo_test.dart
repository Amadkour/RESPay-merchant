import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/registration/providers/Api/end_point.dart';
import 'package:res_pay_merchant/features/authentication/modules/registration/providers/Api/registration_api.dart';
import 'package:res_pay_merchant/features/authentication/modules/registration/providers/repository/registeration_repository.dart';

import '../registration_values.dart';
import 'regsteration_repo_test.mocks.dart';

@GenerateMocks(<Type>[RegistrationAPI])
void main() {
  late MockRegistrationAPI api;
  late RegistrationRepository repo;
  setUpAll(() {
    api = MockRegistrationAPI();
    repo = RegistrationRepository(api);
  });
  group('registration repo testing', () {
    test(
      "verify that success return right operand",
      () async {
        ///assert
        when(api.registration(registrationInputs))
            .thenAnswer((Invocation realInvocation) async {
          return right(
            Response<Map<String, dynamic>>(
              requestOptions: RequestOptions(path: registrationPath),
              data: registrationValues.successfulResponse,
            ),
          );
        });

        //act

        final Either<Failure, String> result =
            await repo.register(registrationInputs);

        final dynamic value = result.fold((Failure l) => null, (String r) => r);

        /// verify
        expect(value, isA<String>());
        expect(value, equals("7159"));
      },
    );

    test(
      "verify that fail case return left operand",
      () async {
        when(api.registration(registrationInputs))
            .thenAnswer((Invocation realInvocation) async {
          return left(ApiFailure());
        });

        final Either<Failure, String> result =
            await repo.register(registrationInputs);
        expect(result, isA<Left<Failure, String>>());
      },
    );
  });
}
