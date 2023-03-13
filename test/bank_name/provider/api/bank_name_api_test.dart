import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/bank_name/provider/api/bank_name/bank_name_remote_api.dart';

import '../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../bank_name_values.dart';

void main() {
  late MockDio mockedDio;
  late BankNameRemoteApi api;

  setUpAll(() {
    mockedDio = MockDio();
    api = BankNameRemoteApi.withDio(dio: mockedDio);
  });
  group("get bank names Api", () {
    test('get bank name Success Test', () async {
      when(mockedDio.get(bankNamesValue.path)).thenAnswer(
        (Invocation realInvocation) async => Response<Map<String, dynamic>>(
          statusCode: 201,
          data: bankNamesValue.successfulResponse,
          requestOptions: RequestOptions(
            path: bankNamesValue.path,
          ),
        ),
      );
      expect(await api.getAllBankNames(), isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });

    test('get bank name Failed Test', () async {
      when(mockedDio.get(bankNamesValue.path)).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 404,
          data: bankNamesValue.failureResponse,
          requestOptions: RequestOptions(
            path: bankNamesValue.path,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getAllBankNames();
      expect(result, isA<Right<Failure, Response<Map<String, dynamic>>>>());
    });
  });
}
