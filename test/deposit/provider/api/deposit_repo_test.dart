import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/deposit/provider/api/deposit_api.dart';

import '../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../../../core/utilis.dart';
import '../deposit_values.dart';

void main() {
  late MockDio dio;
  late DepositRemoteApi api;

  setUpAll(() {
    dio = MockDio();
    api = DepositRemoteApi(dio: dio);
  });

  group("testing deposit request", () {
    test("verify that make deposit api return success", () async {
      when(dio.post(
        depositValues.path,
        data: compare(makeDepositParams.toMap()),
      )).thenAnswer(
        (Invocation realInvocation) async {
          return Response<Map<String, dynamic>>(
            statusCode: 200,
            data: depositValues.successfulResponse,
            requestOptions: RequestOptions(
              path: depositValues.path,
            ),
          );
        },
      );

      final Either<Failure, Response<Map<String, dynamic>>> result = await api.createDeposit(makeDepositParams);
      final Object model = result.fold((Failure l) => l, (Response<Map<String, dynamic>> r) => r);
      expect((model as Response<Map<String, dynamic>>).data, equals(depositValues.successfulResponse));
    });

    test("verify that make deposit api return failed", () async {
      when(dio.post(
        depositValues.path,
        data: compare(makeDepositParams.toMap()),
      )).thenAnswer(
        (Invocation realInvocation) async {
          return Response<Map<String, dynamic>>(
            statusCode: 200,
            data: depositValues.failureResponse,
            requestOptions: RequestOptions(
              path: depositValues.path,
            ),
          );
        },
      );

      final Either<Failure, Response<Map<String, dynamic>>> result = await api.createDeposit(makeDepositParams);
      final Object failure = result.fold((Failure l) => l, (Response<Map<String, dynamic>> r) => r);
      expect(failure, isA<ApiFailure>());
    });
  });
}
