// ignore_for_file: always_specify_types

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/provider/api/pin_provider.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/provider/repo/pin_code_repo.dart';

import '../../pin_code_values.dart';
import 'pin_repo_test.mocks.dart';

@GenerateMocks(<Type>[PinCodeAPI])
void main() {
  late MockPinCodeAPI mockApi;
  late PinCodeRepo repo;

  setUpAll(() {
    mockApi = MockPinCodeAPI();
    repo = PinCodeRepo(mockApi);
  });

  group('pin repo testing ', () {
    test('setup method success state', () async {
      when(mockApi.setUpPinCode('1234', 1, 1))
          .thenAnswer((Invocation realInvocation) async {
        return right(Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(
            path: pinCodeValues.path,
          ),
          data: pinCodeValues.successfulResponse,
        ));
      });

      final Either<Failure, bool> result = await repo.setup('1234', 1, 1);

      expect(result, isA<Right>());
    });

    test('setup method failure state', () async {
      when(mockApi.setUpPinCode('1234', 1, 1))
          .thenAnswer((Invocation realInvocation) async {
        return left(ApiFailure());
      });

      final Either<Failure, bool> result = await repo.setup('1234', 1, 1);

      expect(result, isA<Left>());
    });
  });
}
