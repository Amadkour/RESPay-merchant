// ignore_for_file: always_specify_types

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:res_pay_merchant/core/errors/failures.dart';
import 'package:res_pay_merchant/features/payment/modules/budget/provider/api/remote_budget_api.dart';

import '../../../authentcation/registration/provider/api/regestration_api_test.mocks.dart';
import '../budget_values.dart';

void main() {
  late MockDio mockedDio;

  late RemoteBudgetApi api;
  setUpAll(() {
    mockedDio = MockDio();
    api = RemoteBudgetApi(dio: mockedDio);
  });

  group('load budget testing', () {
    test('verify that load budget return BudgetListModel', () async {
      when(mockedDio.get(getBudgetValues.path, queryParameters: getBudgetValues.successfulParams))
          .thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: getBudgetValues.successfulResponse,
          requestOptions: RequestOptions(
            path: getBudgetValues.path,
          ),
        );
      });

      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getCategories(period: "monthly");

      expect(result, isA<Right>());
    });

    test('verify that load budget return failure', () async {
      when(mockedDio.get(getBudgetValues.path, queryParameters: getBudgetValues.successfulParams)).thenThrow(
        DioError(
          requestOptions: RequestOptions(
            path: getBudgetValues.path,
            data: getBudgetValues.failureResponse,
          ),
        ),
      );

      final Either<Failure, Response<Map<String, dynamic>>> result = await api.getCategories(period: "monthly");

      expect(result, isA<Left>());
    });
  });

  group('budget category testing', () {
    //-----testing get paymentMethod function ----//

    test('verify that add budget category return success', () async {
      when(
        mockedDio.post(
          addBudgetCategoryValues.path,
          data: anything,
        ),
      ).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: addBudgetCategoryValues.successfulResponse,
          requestOptions: RequestOptions(
            path: addBudgetCategoryValues.path,
          ),
        );
      });

      final Either<Failure, Response<Map<String, dynamic>>> result = await api.create(addBudgetSuccessBody);

      expect(result, isA<Right>());
    });

    test('verify that add budget category return failure', () async {
      when(mockedDio.post(addBudgetCategoryValues.path, data: anything)).thenThrow(
        DioError(
          requestOptions: RequestOptions(
            path: addBudgetCategoryValues.path,
            data: addBudgetCategoryValues.failureResponse,
          ),
        ),
      );

      final Either<Failure, Response<Map<String, dynamic>>> result = await api.create(addBudgetSuccessBody);

      expect(result, isA<Left>());
    });

    //-----delete testing ------//

    test('verify that delete budget category return success', () async {
      when(
        mockedDio.post(
          deleteBudgetCategoryValues.path,
          data: anything,
        ),
      ).thenAnswer((Invocation realInvocation) async {
        return Response<Map<String, dynamic>>(
          statusCode: 200,
          data: deleteBudgetCategoryValues.successfulResponse,
          requestOptions: RequestOptions(
            path: deleteBudgetCategoryValues.path,
          ),
        );
      });

      final Option<Failure> result = await api.delete("12345678");

      expect(result, isA<None>());
    });

    test('verify that add budget category return failure', () async {
      when(mockedDio.post(deleteBudgetCategoryValues.path, data: anything)).thenThrow(
        DioError(
          requestOptions: RequestOptions(
            path: deleteBudgetCategoryValues.path,
            data: deleteBudgetCategoryValues.failureResponse,
          ),
        ),
      );

      final Option<Failure> result = await api.delete("");
      final Failure? value = result.fold(() => null, (Failure a) => a);

      expect(value, isA<ApiFailure>());
    });
    //-----update testing ------//

    test('verify that update budget category return success', () async {
      final Response<Map<String, dynamic>> response = Response<Map<String, dynamic>>(
        statusCode: 200,
        data: updateBudgetCategoryValues.successfulResponse,
        requestOptions: RequestOptions(
          path: updateBudgetCategoryValues.path,
        ),
      );
      when(
        mockedDio.post(
          updateBudgetCategoryValues.path,
          data: anything,
        ),
      ).thenAnswer((Invocation realInvocation) async {
        return response;
      });

      final Either<Failure, Response<Map<String, dynamic>>> result = await api.update(updateBudgetSuccessBody);
      final Object value = result.fold((Failure l) => l, (Response<Map<String, dynamic>> r) => r);
      expect(value, equals(response));
    });

    test('verify that update budget category return failure', () async {
      when(mockedDio.post(updateBudgetCategoryValues.path, data: anything)).thenThrow(
        DioError(
          requestOptions: RequestOptions(
            path: updateBudgetCategoryValues.path,
            data: updateBudgetCategoryValues.failureResponse,
          ),
        ),
      );

      final Either<Failure, Response<Map<String, dynamic>>> result = await api.update(updateBudgetSuccessBody);
      final Object value = result.fold((Failure l) => l, (Response<Map<String, dynamic>> r) => r);

      expect(value, isA<ApiFailure>());
    });
  });
}
