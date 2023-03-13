// ignore_for_file: always_specify_types

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/otp/provider/api/otp_provider.dart';
import 'package:res_pay_merchant/features/authentication/modules/otp/provider/repo/otp_repo.dart';

import '../../otp_values.dart';
import 'otp_repo_test.mocks.dart';

@GenerateMocks(<Type>[OtpApi])
void main() {
  late MockOtpApi mockOtpApi;
  late OtpRepo repo;

  setUpAll(() {
    mockOtpApi = MockOtpApi();
    repo = OtpRepo(mockOtpApi);
  });

  group('otp repo testing', () {
    test('verify otp return proper message when success', () async {
      when(mockOtpApi.sendOTP(successfulBody))
          .thenAnswer((Invocation value) async {
        return right(Response(
          requestOptions: RequestOptions(
            path: otpValues.path,
          ),
          data: otpValues.successfulResponse,
          statusCode: 200,
        ));
      });
      final result = await repo.verify(successfulBody);

      expect(result, isA<Right>());
    });
    test('verify otp return proper failure on error', () async {
      when(mockOtpApi.sendOTP(failureBody))
          .thenAnswer((Invocation value) async {
        return left(ApiFailure());
      });
      final result = await repo.verify(failureBody);

      expect(result, isA<Left>());
    });
  });
}
