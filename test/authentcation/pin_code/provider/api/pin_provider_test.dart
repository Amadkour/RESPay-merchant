// ignore_for_file: always_specify_types

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/features/authentication/modules/pin_code/provider/api/pin_provider.dart';

import '../../../../core/utilis.dart';
import '../../../registration/provider/api/regestration_api_test.mocks.dart';
import '../../pin_code_values.dart';

void main() {
  late MockDio dio;

  late PinCodeAPI api;

  setUpAll(() {
    dio = MockDio();
    api = PinCodeAPI(dio: dio);
  });

  group('pin code api testing', () {
    test('setUpPinCode test success state', () async {
      when(dio.post(pinCodeValues.path, data: compare(pinCodeValues.successfulBody!)))
          .thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(
            path: pinCodeValues.path,
          ),
          statusCode: 200,
          data: pinCodeValues.successfulResponse,
        );
      });

      final result = await api.setUpPinCode('1234', 1, 1);
      expect(result, isA<Right>());
    });

    test('setUpPinCode test failure state', () async {
      when(dio.post(pinCodeValues.path, data: compare(pinCodeValues.failureBody!)))
          .thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(
            path: pinCodeValues.path,
          ),
          data: pinCodeValues.failureResponse,
        );
      });

      final result = await api.setUpPinCode('1234', 1, 1);
      expect(result, isA<Left>());
    });
  });
}
