// ignore_for_file: always_specify_types

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/authentication/modules/otp/provider/api/otp_provider.dart';

import '../../../../core/utilis.dart';
import '../../../registration/provider/api/regestration_api_test.mocks.dart';
import '../../otp_values.dart';

void main() {
  late MockDio dio;
  late OtpApi api;

  setUpAll(() {
    dio = MockDio();
    api = OtpApi(d: dio);
  });

  group('test otp api ', () {
    test('verify that send otp return right proper response on success', () async {
      when(dio.post(otpValues.path, data: compare(otpValues.successfulBody!)))
          .thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(
            path: otpValues.path,
          ),
          data: otpValues.successfulResponse,
          statusCode: 200,
        );
      });

      final Either<Failure, Response<Map<String, dynamic>>> result = await api.sendOTP(successfulBody);
      final Object response = result.fold((Failure l) => l, (Response<Map<String, dynamic>> r) => r);
      expect((response as Response).data, equals(successfulResponse));
    });

    test('verify that send otp return left proper response on failure', () async {
      when(dio.post(otpValues.path, data: compare(otpValues.failureBody!))).thenAnswer((realInvocation) async {
        return Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(
            path: otpValues.path,
          ),
          data: otpValues.failureResponse,
        );
      });

      final result = await api.sendOTP(failureBody);

      expect(result, isA<Left>());
    });
  });
}
