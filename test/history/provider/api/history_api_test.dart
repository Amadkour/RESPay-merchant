import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/history/provider/api/remote_transaction_api.dart';

import '../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../history_values.dart';

void main() {
  late MockDio dio;
  late HistoryApi api;

  setUpAll(() {
    dio = MockDio();
    api = HistoryApi(dio: dio);
  });

  group("wallet api testing", () {
    test("verify that get wallet api return success", () async {
      when(dio.get(getWalletValues.path)).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          data: getWalletValues.successfulResponse,
          requestOptions: RequestOptions(path: getWalletValues.path),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getWallet();
      final Object response = result.fold((Failure l) => l, (Response<Map<String, dynamic>> r) => r);
      expect((response as Response<Map<String, dynamic>>).data, equals(getWalletValues.successfulResponse));
    });

    test("verify that get wallet api return failure", () async {
      when(dio.get(getWalletValues.path)).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          data: getWalletValues.failureResponse,
          requestOptions: RequestOptions(path: getWalletValues.path),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getWallet();
      final Object response = result.fold((Failure l) => l, (Response<Map<String, dynamic>> r) => r);
      expect(response, isA<Failure>());
    });
  });

  group("history api testing", () {
    test("verify that get history api return success", () async {
      when(dio.get(
        getHistoryValues.path,
        queryParameters: getHistoryValues.successfulParams,
      )).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          data: getHistoryValues.successfulResponse,
          requestOptions: RequestOptions(
            path: getHistoryValues.path,
            queryParameters: getHistoryValues.successfulParams,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result =
          await api.getTransactions(filters: filterHistoryParams);
      final Object response = result.fold((Failure l) => l, (Response<Map<String, dynamic>> r) => r);
      expect((response as Response<Map<String, dynamic>>).data, equals(getHistoryValues.successfulResponse));
    });

    test("verify that get history api return failure", () async {
      when(dio.get(
        getHistoryValues.path,
        queryParameters: getHistoryValues.successfulParams,
      )).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          data: getHistoryValues.failureResponse,
          requestOptions: RequestOptions(
            path: getHistoryValues.path,
            queryParameters: getHistoryValues.successfulParams,
          ),
        );
      });
      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getTransactions(
        filters: filterHistoryParams,
      );
      final Object response = result.fold((Failure l) => l, (Response<Map<String, dynamic>> r) => r);
      expect(response, isA<Failure>());
    });
  });
}
